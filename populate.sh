#!/bin/bash
#shellcheck disable=2155

d() {
    date '+%F %H:%M:%S.%6N'
}

new_nutr() {
    echo "INSERT INTO nutritionists
          (name, number, clinic, street, city, personal_page, price, created_at, updated_at)
          VALUES ('$1', '$2', '$3', '$4', '$5', '$6', '$7', '$8', '$9')
          RETURNING id"
}

new_tag() {
    echo "INSERT INTO tags
          (name, created_at, updated_at)
          VALUES ('$1', '$2', '$3')
          RETURNING id"
}

new_relation() {
    echo "INSERT INTO nutritionists_tags
          (nutritionist_id, tag_id)
          VALUES ('$1', '$2')"
}

mocks=(
    "Matilde  | 1N    | archive          | Rua do Monte        | Braga  | http://pasok.xyz   | 0  | $(d)"
    "Mendes   | 2N    | tolaria          | Rua da Torre        | Braga  | http://mendess.xyz | 2  | $(d)"
    "JTexeira | 362N  | thinkpad         | Rua de Mondim       | Braga  | http://bunker.xyz  | 64 | $(d)"
    "Jff      | 5346N | thonkpad         | Rua do Sotao        | Braga  | http://jff.sh      | 32 | $(d)"
    "Miguel   | 7654N | UCAL             | Rua da Praia        | Apulia | https://solino.dev | 45 | $(d)"
    "Afonso   | 1890N | /dev/null        | Rua da Cave         | Braga  | http://oracle.bat  | 30 | $(d)"
    "Ana      | 890N  | Delegacoes       | Rua da Universidade | Braga  | http://milady.xyz  | 50 | $(d)"
    "Emanuel  | 3192N | Clinica do Lago  | Rua da Aldeia       | Braga  | http://sapo.pt     | 33 | $(d)"
    "Marcia   | 132N  | Clinica da Massa | Rua de Cabeceiras   | Aldeia | http://segfault.c  | 22 | $(d)"
)

tags=(desportivo emagrecimento saude dieta)

mock_tags=(
    "1"
    "0 | 1"
    "0"
    "2"
    ""
    "3"
    "0 | 3"
)

./manage_db.sh s -c 'truncate nutritionists_tags; truncate nutritionists; truncate tags'

export PGPASSWORD=foo
export PGDATABASE=esmeraldas_em_autoestradas_development
export PGHOST=$(./manage_db.sh ip)
export PGUSER=postgres

tag_ids=()
for t in "${tags[@]}"; do
    d="$(d)"
    tag_ids+=("$(psql -c "$(new_tag "$t" "$d" "$d")" | sed -n 3p | xargs)")
    echo "tag: ${tag_ids[-1]}"
done

tag_index=0
for m in "${mocks[@]}"; do
    IFS="|" read -ra mock <<< "$m"
    for i in $(seq 0 $((${#mock[@]} - 1))); do
        mock[$i]="$(echo "${mock[$i]}" | xargs)" # trim strings
    done
    id=$(psql -c "$(new_nutr "${mock[@]}" "${mock[-1]}")" | sed -n 3p | xargs)
    echo "nutri: $id"

    IFS="|" read -ra tag_numbers <<< "${mock_tags[$tag_index]}"
    for t in "${tag_numbers[@]}"; do
        psql -c "$(new_relation "$id" "${tag_ids[$t]}")" >/dev/null &&
            echo "$id <-> ${tag_ids[$t]}"
    done
    ((tag_index++))
done
