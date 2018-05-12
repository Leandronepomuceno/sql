Cláusula TOP
------------

--Selecione os 10 primeiros registros da tabela de clientes

--Selecione os 15 primeiros registros da tabela de vendedores

--Selecione o número e o valor das 20 notas fiscais de maior valor

--Selecione o número e o valor das 20 notas fiscais de menor valor

Rank Functions
--------------
Rank functions é um recurso muito podereso disponível no SQL SERVER.
Usamos este recurso para classificar nossos dados, montando um RANK em nosso resultado.

/*
Vamos montar um RANK das notas fiscais, retornando o número da nota fiscal, o valor total, e sua classificação
no rank.
Veja o resultado esperado:

nu_nf       vl_total                                ordem
----------- --------------------------------------- --------------------
5000062     600000.0000                             1
5000606     600000.0000                             2
289496      595000.0000                             3
289548      560000.0000                             4
5000178     560000.0000                             5
5000486     450000.0000                             6
291088      450000.0000                             7
5003855     450000.0000                             8
5005426     450000.0000                             9
290103      407250.0000                             10
290488      387500.0000                             11
292354      380950.0000                             12
...			...										...
...			...										...

*/

select	nu_nf,
		vl_total,
		row_number() over (order by vl_total desc) as ordem
from	nota

/*
O diretor financeiro gostou muito do seu relatório de RANK de notas fiscais!
No entanto, ele teve uma idéia melhor: Montar um rank de notas fiscais quebrado por cliente.

A tarefa já está contigo, monte um rank de notas fiscais quebrado por cliente.
Veja o resultado esperado:

cd_clien    nu_nf       vl_total                                ordem
----------- ----------- --------------------------------------- --------------------
45          286850      760.0000                                1
45          288084      711.0000                                2
45          289937      711.0000                                3
45          285136      630.0000                                4
74          291559      1079.0000                               1
74          5003933     1040.4000                               2
74          5005219     887.4000                                3
74          291920      882.0000                                4
74          5001172     795.0000                                5
74          5001737     748.0000                                6
74          5001839     716.0000                                7
74          5005981     702.0000                                8
74          5002922     628.0000                                9
74          5001458     538.0000                                10
74          5004219     496.8000                                11
74          5000535     429.0000                                12
74          5002121     426.0000                                13
74          5004026     358.0000                                14
74          5004040     352.8000                                15
74          5005772     327.6000                                16
74          5004753     324.0000                                17
74          5006103     302.4000                                18
74          5003808     270.0000                                19
105         5004831     2610.0000                               1
105         5000864     1921.5000                               2
105         290340      1463.5200                               3
105         5006129     785.7000                                4
109         5000299     2265.2000                               1
109         5004037     1764.4000                               2
109         288219      1763.0800                               3
...			...			...										...
...			...			...										...
*/

select	cd_clien,
		nu_nf,
		vl_total,
		row_number() over (partition by cd_clien order by vl_total desc) as ordem
from	nota

/*
Não satisfeito com os dois relatórios de RANK de notas fiscais que você acabou de fazer, o diretor financeiro
enviou mais uma solicitação para o pessoal de TI.
Como você já estava atendendo as solicitações dele, pegou mais esta atividade.

Agora o diretor quer o relatório de RANK de notas fiscais quebrado por vendedor.
O resultado esperado (resumido) é:

cd_vend              nu_nf       vl_total                                ordem
-------------------- ----------- --------------------------------------- --------------------
NULL                 287981      125100.0000                             1
NULL                 284864      12685.5000                              2
NULL                 286451      1600.0000                               3
NULL                 5004564     747.0000                                4
NULL                 285940      150.0000                                5
NULL                 288671      141.0000                                6
1                    287822      40000.0000                              1
1                    287546      14644.8000                              2
1                    5000275     13880.5300                              3
1                    285530      9757.0000                               4
1                    290138      9143.4000                               5
1                    291626      9143.4000                               6
10                   5000969     81550.0000                              1
10                   284719      41580.0000                              2
10                   5001806     25000.0000                              3
10                   285652      22680.0000                              4
10                   285223      19800.0000                              5
10                   286416      19089.0000                              6
10                   284801      18667.0000                              7
...					 ...		 ...									 ...
...					 ...		 ...									 ...

*/

select	cd_vend,
		nu_nf,
		vl_total,
		row_number() over (partition by cd_vend order by vl_total desc) as ordem
from	nota

/*
Divida o cadastro de clientes em 10 grupos iguais.
*/

select	*,
		ntile(10) over (order by cd_clien) 
from	cliente

/*
A gerência de vendas da sua empresa resolveu alterar a forma de trabalho dos vendedores.
Hoje, os vendedores são divididos por equipe, no entando agora será necessário criar uma nova divisão chamada
sub_equipe.
A regra de negócio definida pelo gerente diz que cada equipe deve possuir três sub_equipes.

Exemplo:
cd_equipe	sub_equipe
---------	----------
1			1
1			2
1			3
2			1
2			2
2			3

Você deve montar um comando select que retorne os vendedores distribuidos em suas equipes e sub_equipes.
A equipe já está na tabela de vendedores, você deve apenas montar o campo sub_equipe (distribuir os vendedores
da equipe em três grupos). Veja o resultado esperado:

cd_vend              nome                                               cd_equipe   sub_equipe
-------------------- -------------------------------------------------- ----------- --------------------
10                   ANTONIA MARQUES DA COSTA                           1           1
100                  NASCA COM REPRESENTACOES LTDA                      1           1
101                  NICKEL SUL REPRESENTACOES COM LTDA                 1           1
102                  NOVA LIDERANCA COM. E REPR. LTDA.                  1           1
103                  OLIVEIRA FATURI                                    1           1
104                  OLIVEIRA REPRESENTACOES LTDA                       1           1
105                  ORIVALDO LIMA CARDOSO DE OLIVEIRA                  1           1
106                  OSCAR MASAYOSHI HYODO                              1           1
107                  PARAISO REPRESESENTACOES LTDA                      1           1
108                  PEDRO FERNANDES                                    1           1
109                  PEDRO ESTEVES DA SILVA                             1           1
11                   LEANDRA APARECIDA MACHITE PRIMINI                  1           1
110                  POLO COMERCIAL LTDA                                1           1
111                  PRP REPRESENTACOES                                 1           1
112                  R.J.S. DE MELO - ME                                1           1
113                  RAPHAEL CARRIERI                                   1           1
114                  RAUL CORDEIRO (TRIGAL)                             1           1
115                  RICARDO ALBERTO MARQUES                            1           1
117                  ROGERIO C. BARBOSA                                 1           1
118                  RONALDO SOARES GOULART                             1           1
119                  PAULO ROGERIO BONACINA                             1           1
12                   ANTONIO ASSUNCAO TONY GUARIGLIA                    1           1
120                  SIMONE ANDREZA GOUVEA                              1           1
121                  SIRLEY MARTINS HENRIQUES                           1           1
122                  SIUK COMÉRCIO E REPR. LTDA                         1           1
123                  SIZINO BATISTA SANTOS                              1           1
124                  S.R.P REPRESENTANTES                               1           1
125                  STELA VIEIRA                                       1           1
126                  TELMA APARECIDA CORTELLO                           1           1
127                  ANTONIO SCARIN                                     1           1
128                  UNI REPRES. LTDA                                   1           1
129                  VERA LUCIA CALLAS FERNANDES                        1           1
13                   ANTONIO CARLOS XIMENEZ                             1           1
130                  VIA SUL COML DE GEN.ALIM.BEB                       1           1
131                  WALDEMAR DE SOUZA GOMES                            1           1
132                  WALDIR ZANOTTI                                     1           1
134                  DECIO MANNA                                        1           1
135                  LEONARDO PALAZZO                                   1           1
137                  ANDRE LUIZ DANTAS DA SILVA                         1           1
14                   ANTONIO FEDERICO                                   1           1
140                  JOSE CARLOS PIRES                                  1           1
141                  PETITINGA REPRESENTACOES LTDA                      1           1
142                  JAILTON ROCHA XAVIER                               1           1
143                  AGOSTINHO NETO DOS SANTOS                          1           1
144                  JSN REPRESENTACOES LTDA                            1           1
145                  EDUARDO RODRIGUES MENDES                           1           1
146                  PAULO ROBERTO RODRIGUEZ CALDAS                     1           1
148                  AMELIA MARGARETE MORAES                            1           1
149                  CRISTIANO DE OLIVEIRA RANGEL                       1           1
15                   ANTONIO FRANCO DA SILVEIRA                         1           1
150                  PRISCILA DE AQUINO CARUSO                          1           1
151                  CAMPOS MACHADO REPRES. COM. S/C LTDA-ME            1           1
152                  DAMARIS MATHEUS CAETANO                            1           1
153                  RED FOOD BROKERS REPRESENTACOES LTDA               1           2
154                  ANTONIO PEREIRA DA SILVA                           1           2
155                  JOSE BARGIELO LARUCCIA                             1           2
156                  MARIO DE ANDRADE PACHECO                           1           2
157                  PRA´LIMENTAR COM. REP. DISTR. LTDA                 1           2
158                  BENITO COMERCIO E REPRESENTACOES LTDA              1           2
159                  FLORIO REPRESENTACAO COMERCIAL LTDA                1           2
16                   ANTONIO LUIZ DE FREITAS                            1           2
160                  EZIO & M. OLIVEIRA REORE. COMERCIAIS LTD           1           2
161                  WAGNER DE SOUZA                                    1           2
162                  G.S.P. REPRESENTACOES                              1           2
163                  FERNANDES E FERNANDES REPRESENTACOES LTD           1           2
164                  MECTUDOS REPRESENTACOES LTDA                       1           2
165                  JOSELITO NEVES MARTINS                             1           2
166                  JOSE RUBENS JULIANO                                1           2
17                   ANTONIO REIS PEREIRA                               1           2
18                   ARLINDO MARTINS                                    1           2
19                   BERIA XAVIER TEMPERANI                             1           2
2                    A.S. OLIVEIRA REPRESENTACOES                       1           2
20                   BETEL REPRESENTACOES                               1           2
21                   BRASPORT COM E REPRESENTACOES                      1           2
22                   CRM REPRESENTACOES COM LTDA                        1           2
23                   CAMILA (C.L. REPRESENTACOES)                       1           2
24                   CANAÃ REPRESENTACOES LTDA                          1           2
25                   CANCANCAO REPRES COM LTDA                          1           2
26                   CARDOSO E MARCIANO REPRESENTACOES                  1           2
27                   CARLOS EDUARDO BOLSANELLO ALMEIDA                  1           2
28                   CEDIO DE FREITAS BATISTA                           1           2
29                   CEDRO REPRES LTDA - PABLO                          1           2
3                    ACIR RIZZI                                         1           2
30                   CELIZA REPRESENTACOES                              1           2
31                   CELESTE REPRESENTACOES                             1           2
32                   CHAIM REPRESENTACOES LTDA                          1           2
33                   CLAUDINEI REPRESENTACOES                           1           2
34                   CLAUDIO RIGHI DE LIMA                              1           2
35                   COMENDADOR REPRESENTACOES                          1           2
36                   CONSULT MIX REPRESENTACOES                         1           2
37                   DANILO RICARDO CALABRA MUNIZ                       1           2
38                   DAYSE BARBOSA SILVA                                1           2
39                   DEJAIR BALBINO                                     1           2
40                   DELAMO REPRESENTACOES COM LTDA                     1           2
41                   DIETER LINDEMBERG                                  1           2
42                   DIRCEU GOVEIA REPRESENTACOES                       1           2
43                   DYONIZIO PIEROTTI                                  1           2
44                   DIRETO                                             1           2
45                   ECO EMPREENDIMENTOS COMERCIAIS                     1           2
46                   EDSON MONTE DE OLIVEIRA                            1           2
47                   EDUARDO A.A. GALLO                                 1           2
48                   EDUARDO ARAUJO MATEUS FILHO                        1           2
49                   EDUARDO DIAS NETO                                  1           2
5                    ALEXANDRE CALIPO                                   1           2
50                   EDUARDO DOS SANTOS                                 1           2
51                   ELIOMAR DA SILVA VALENCIA                          1           3
52                   EMIVALDO DELFINO (PENINHA)                         1           3
53                   ENFOQUE REPRESENTAÇOES                             1           3
54                   EUFRATES COM,IMP.PROD.MANUFATURADO L               1           3
55                   F.H.E CORRETORA (HERBET-FABIO)                     1           3
56                   F.P.GOMES (ME) (RENASCER)                          1           3
57                   FRANCISCO OSALIO RAMOS                             1           3
58                   GILSON-REP.SHOP CHEESE                             1           3
59                   GUILHERME DE OLIVEIRA GIFFONI                      1           3
6                    ALEXANDRE CARLOS CALLAS                            1           3
60                   GUNTER RODOLPHO BERING                             1           3
61                   H.F COM.E REP.DE BEBIDAS E ALIMENTOS               1           3
62                   HELIMAR REPRESENTATES (HELINHO)                    1           3
63                   HELIO ROBERTO MENDES CORNELIO                      1           3
64                   HUBIABA COM.E REPRES.LTDA                          1           3
65                   HUMBERTO MOREIRA GONÇALVES                         1           3
66                   J.C.C.F.REPRESENTAÇOES LTDA                        1           3
67                   J.L.S. REPRESENTAÇOES COMERCIAIS LTDA              1           3
68                   JAILTON LUIZ                                       1           3
69                   JBM.REPRES.LTDA                                    1           3
70                   JOAO HORACIO PEREIRA                               1           3
71                   JOAO VIRGILIO A.NUNES                              1           3
72                   JOSE CARLOS ANTONIOLI                              1           3
73                   JOSE EDUARDO BARCELOS COELHO                       1           3
74                   JOSE MANSUR KAIRALA                                1           3
75                   JR CORRET DE GEN ALIM                              1           3
76                   JULIO KRUSE FUGANTI                                1           3
77                   JUNIOR'S REPRESETACOES COM LTDA                    1           3
79                   LEOPOLDO A.A. GALLO                                1           3
8                    ANDERSON VIANA KHALIL                              1           3
80                   LORD CORRETORA                                     1           3
81                   LUCAS ANTERO CORREIA FILHO                         1           3
82                   LUZIA RODRIGUES DE SOUZA                           1           3
83                   MAGITON COM. E REP.LTDA                            1           3
84                   MANOEL CARDOSO DA COSTA SANTOS                     1           3
85                   MANUEL ARLINDO GRANJO FERREIRA                     1           3
86                   MARAGIBA MIGUEL DA SILVA RUAS                      1           3
87                   MARCELO DINIS PINA (IMPEX CORRETORA)               1           3
88                   MARCOS LUIZ BACCARA                                1           3
89                   MARIA GLORIA DE JESUS                              1           3
9                    ANDREA MARIA PESSOA DE LIMA                        1           3
90                   MARIA RACHEL SALLES                                1           3
91                   MARINHO & PINHEIRO                                 1           3
92                   MARIO CESAR CAETANO                                1           3
93                   MARIO DE OLIVEIRA PEREIRA                          1           3
94                   MARIO JOSE SCHIMIDT CHAIN                          1           3
95                   MARLI MOURO GIOVANETTI                             1           3
96                   MAURILIO GOMES DE OLIVEIRA                         1           3
97                   MEGA CORRETORA                                     1           3
98                   MILANEZ REPRESENTACOES                             1           3
99                   MIRAJUZ REPRESTACOES COM LTDA                      1           3
TALITA               TALITA                                             1           3
116                  ROBERTA MACEDO                                     2           1
138                  CLAUDIO IGINO DA SILVA                             2           2
139                  LAURA FRANCISCA CARRER                             2           3
133                  MARCOS ALEXANDRE PAULINO                           3           1
136                  SERGIO JUVENAL DA SILVA                            3           1
4                    ALBERTO/CELSO                                      3           2
7                    ALUISIO SOUZA BASILIO                              3           2
78                   LEANDRO CHICARELLI                                 3           3
SUPER                SUPER USUÁRIO DO SISTEMA                           3           3
1                    ZOIRA SOBREIRA                                     4           1
147                  RODRIGO SANTOS DA COSTA                            4           1
CLEITON              CLEITON SANTOS                                     4           1
GORETE               GORETE                                             4           2
LEONARDO             LEONARDO ZIMMERMANN                                4           2
PAULINHO             PAULO VINICIUS SILVA                               4           2
VEN                  VENDEDOR GENERICO                                  4           3
VERBAE1              VERBAE1                                            4           3
VERBAE2              VERBAE2                                            4           3

(175 row(s) affected)


*/

select	cd_vend, 
		nome,
		cd_equipe, 
		ntile(3) over (partition by cd_equipe order by cd_vend) as sub_equipe
from	vendedor
order by cd_equipe

/*
Vamos montar um RANK das notas fiscais, retornando o número da nota fiscal, o valor total, e sua classificação
no rank.
Veja o resultado esperado:

nu_nf       vl_total                                ordem
----------- --------------------------------------- --------------------
5000062     600000.0000                             1
5000606     600000.0000                             1
289496      595000.0000                             3
289548      560000.0000                             4
5000178     560000.0000                             4
5000486     450000.0000                             6
291088      450000.0000                             6
5003855     450000.0000                             6
5005426     450000.0000                             6
290103      407250.0000                             10
290488      387500.0000                             11
292354      380950.0000                             12
290725      355093.2500                             13
291818      310000.0000                             14
289805      287670.0000                             15
290637      285000.0000                             16
291163      261515.0000                             17
290941      260686.0000                             18
5004667     255700.0000                             19
292100      246500.0000                             20
292175      246500.0000                             20
5001239     240000.0000                             22
5005503     240000.0000                             22
5004164     232311.2500                             24
284999      228570.0000                             25
291164      226875.0000                             26
290939      225600.0000                             27
5002264     212070.0000                             28
5001525     210642.0000                             29
292305      202150.0000                             30
5000488     200030.0000                             31
287910      196776.0000                             32
5004217     194448.0000                             33
5005936     185700.0000                             34
5000069     185620.0000                             35
292310      182325.0000                             36
5006416     166000.0000                             37
290816      161250.0000                             38
5005629     160600.0000                             39
289514      150200.0000                             40
291995      147000.0000                             41
5002381     145200.0000                             42
5000318     128025.0000                             43
287981      125100.0000                             44
290569      124700.0000                             45
290581      124700.0000                             45
5002798     120520.0000                             47
5002799     120520.0000                             47
5000760     116400.0000                             49
5005030     113900.0000                             50
...			...										...
...			...										...

*/

select	nu_nf,
		vl_total,
		rank() over (order by vl_total desc) as ordem
from	nota

/*
Vamos montar um RANK das notas fiscais, retornando o número da nota fiscal, o valor total, e sua classificação
no rank.
Veja o resultado esperado:

nu_nf       vl_total                                ordem
----------- --------------------------------------- --------------------
5000062     600000.0000                             1
5000606     600000.0000                             1
289496      595000.0000                             2
289548      560000.0000                             3
5000178     560000.0000                             3
5000486     450000.0000                             4
291088      450000.0000                             4
5003855     450000.0000                             4
5005426     450000.0000                             4
290103      407250.0000                             5
290488      387500.0000                             6
292354      380950.0000                             7
290725      355093.2500                             8
291818      310000.0000                             9
289805      287670.0000                             10
290637      285000.0000                             11
291163      261515.0000                             12
290941      260686.0000                             13
5004667     255700.0000                             14
292100      246500.0000                             15
292175      246500.0000                             15
5001239     240000.0000                             16
5005503     240000.0000                             16
5004164     232311.2500                             17
284999      228570.0000                             18
291164      226875.0000                             19
290939      225600.0000                             20
5002264     212070.0000                             21
5001525     210642.0000                             22
292305      202150.0000                             23
5000488     200030.0000                             24
287910      196776.0000                             25
5004217     194448.0000                             26
5005936     185700.0000                             27
5000069     185620.0000                             28
292310      182325.0000                             29
5006416     166000.0000                             30
290816      161250.0000                             31
5005629     160600.0000                             32
289514      150200.0000                             33
291995      147000.0000                             34
5002381     145200.0000                             35
5000318     128025.0000                             36
287981      125100.0000                             37
290569      124700.0000                             38
290581      124700.0000                             38
5002798     120520.0000                             39
5002799     120520.0000                             39
5000760     116400.0000                             40
5005030     113900.0000                             41
...			...										...
...			...										...

*/

select	nu_nf,
		vl_total,
		dense_rank() over (order by vl_total desc) as ordem
from	nota

