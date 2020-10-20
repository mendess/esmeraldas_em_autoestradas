#!/bin/bash
#shellcheck disable=2155

sql() {
    echo "INSERT INTO nutritionists
          (name, number, clinic, street, city, personal_page, price, created_at, updated_at)
          VALUES ('$1', '$2', '$3', '$4', '$5', '$6', '$7', '$8', '$9')"
}

mocks=(
    "Matilde  | 1N    | archive          | Rua do Monte        | Braga  | http://pasok.xyz   | 0  | $(date '+%F %H:%M:%S.%6N')"
    "Pedro    | 2N    | tolaria          | Rua da Torre        | Braga  | http://mendess.xyz | 2  | $(date '+%F %H:%M:%S.%6N')"
    "JTexeira | 362N  | thinkpad         | Rua de Mondim       | Braga  | http://bunker.xyz  | 64 | $(date '+%F %H:%M:%S.%6N')"
    "Jff      | 5346N | thonkpad         | Rua do Sotao        | Braga  | http://jff.xyz     | 32 | $(date '+%F %H:%M:%S.%6N')"
    "Miguel   | 7654N | UCAL             | Rua da Praia        | Apulia | https://solino.dev | 45 | $(date '+%F %H:%M:%S.%6N')"
    "Afonso   | 1890N | /dev/null        | Rua da Cave         | Braga  | http://oracle.bat  | 30 | $(date '+%F %H:%M:%S.%6N')"
    "Ana      | 890N  | Delegacoes       | Rua da Universidade | Braga  | http://milady.xyz  | 50 | $(date '+%F %H:%M:%S.%6N')"
    "Emanuel  | 3192N | Clinica do Lago  | Rua da Aldeia       | Braga  | http://sapo.pt     | 33 | $(date '+%F %H:%M:%S.%6N')"
    "Marcia   | 132N  | Clinica da Massa | Rua de Cabeceiras   | Aldeia | http://segfault.c  | 22 | $(date '+%F %H:%M:%S.%6N')"
)

export PGPASSWORD=foo
export PGDATABASE=esmeraldas_em_autoestradas_development
export PGHOST=$(./manage_db.sh ip)
export PGUSER=postgres

for m in "${mocks[@]}"; do
    IFS="|" read -ra mock <<< "$m"
    for i in $(seq 0 $((${#mock[@]} - 1))); do
        mock[$i]="$(echo "${mock[$i]}" | xargs)" # trim strings
    done
    psql -c "$(sql "${mock[@]}" "${mock[-1]}")"
done
