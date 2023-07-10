programa
{
	//Nome: Ana Julia da Silva Soares
	//Matrícula: 2023000874
	
	inclua biblioteca Texto --> tx
	inclua biblioteca Tipos --> tp
	
	funcao inicio(){
		inteiro opcao = -1
		const inteiro qtd=3
		cadeia registros[qtd][5]
		inteiro contador_de_registros=0

		enquanto(opcao < 7){
			opcao = Menu()
			escolha(opcao){
				caso 1: 
					se(Cadastrar_elemento(registros,contador_de_registros, qtd)){
						escreva("Cadastro realizado com sucesso!\n")
						Pressione_Enter()
						contador_de_registros++
					} 
					senao {
						limpa()
						escreva("Número máximo de cadastros atingidos...\n")
						Pressione_Enter()
					} 
				pare
				caso 2:
					Consultar_elemento(registros, qtd)
				pare
				caso 3:
					Listar_dados(registros,contador_de_registros, qtd)
				pare
				caso 4:
					Alterar_elemento(registros, qtd, contador_de_registros)
				pare
				caso 5:
					se(Excluir_elemento(registros,qtd)){
						contador_de_registros--
					}
				pare
				caso 6:
					Gerar_relatorio(registros, qtd)
				pare
				caso 7:
				pare
			} // fim escolha
		} // fim enquanto 
	}
	
	funcao inteiro Menu(){
		cadeia opcao
		inteiro opcao_inteiro = -1

		enquanto (opcao_inteiro == -1){
			limpa()
			escreva("*********************************************\n")
			escreva("*          CADASTRO OBRAS DE ARTE           *\n")
			escreva("")
			escreva("*********************************************\n")
			escreva("*                                           *\n")
			escreva("*  (1)- CADASTRAR ELEMENTO                  *\n")
			escreva("*  (2)- CONSULTAR ELEMENTO                  *\n")
			escreva("*  (3)- LISTAR DADOS                        *\n")
			escreva("*  (4)- ALTERAR ELEMENTO                    *\n")
			escreva("*  (5)- EXCLUIR ELEMENTO                    *\n")
			escreva("*  (6)- RELATORIO                           *\n")
			escreva("*  (7)- SAIR                                *\n")
			escreva("*                                           *\n")
			escreva("*********************************************\n\n")
			leia(opcao)
			se (tp.cadeia_e_inteiro(opcao,10)){
				opcao_inteiro = tp.cadeia_para_inteiro(opcao, 10)		
				se (opcao_inteiro<1 ou opcao_inteiro>7){
					escreva("\nDigite um número válido:\n")
					opcao_inteiro = -1
					Pressione_Enter()	
				}
			}
			senao {
				 escreva("\nDigite um número válido:\n")
				 Pressione_Enter()
			}
		} // fim enquanto opcao_inteiro
		retorne opcao_inteiro
	}

	funcao logico Cadastrar_elemento(cadeia matriz[][], inteiro contador, inteiro limite){
		cadeia entrada
		inteiro linha_vaga = 0

		limpa()
		linha_vaga = Procura_primeira_linha(matriz, limite)
		se (linha_vaga > -1){
			escreva("***** CADASTRO *****\n\n\n")
			escreva("Titulo da obra : ")
			leia(entrada)
			entrada = Verifica_titulo(matriz, entrada, limite, contador)
			matriz[linha_vaga][0] = entrada
			escreva("Nome do artista: ")
			leia(entrada)
			enquanto(Apenas_espacos(entrada) ou (tx.numero_caracteres(entrada)<3) ou (tp.cadeia_e_inteiro(entrada,10))){
				escreva("\nCampo inválido. Digite novamente: apenas cadeias a partir de 3 caracteres.\n")
				leia(entrada)
			}	
			matriz[linha_vaga][1] = entrada
			escreva("Ano de criação: ")
			leia(entrada)
			enquanto(tp.cadeia_e_inteiro(entrada,10) == falso ou ((tp.cadeia_para_inteiro(entrada, 10)>2023) ou ((tp.cadeia_para_inteiro(entrada, 10)<1000))) ){
				escreva("\nCampo inválido. Digite novamente: apenas números inteiros de 1000 até 2023.\n")
				leia(entrada)
			}
			matriz[linha_vaga][2] = entrada
			Escolhe_material(matriz, linha_vaga)
			Escolhe_genero(matriz, linha_vaga)
			limpa()
			retorne verdadeiro		
		} // fim se linha_vaga
		senao 
			retorne falso
		}

	funcao Consultar_elemento(cadeia matriz[][], inteiro limite){
		cadeia titulo
		inteiro contador1
		inteiro localizacao = -1 
		
		limpa()
		escreva("***** CONSULTAR ELEMENTO *****\n\n")
		escreva("Digite o título da obra que você deseja consultar:  ")
		leia(titulo)
		para(contador1=0; contador1<limite; contador1++){
			se(matriz[contador1][0] != ""){
				se(tx.caixa_baixa(matriz[contador1][0])==tx.caixa_baixa(titulo)){
					localizacao = contador1
				}		
			}	
		}
			se (localizacao > -1){
				Lista_dados_elemento(matriz,localizacao)
			}
			senao {
				escreva("\nObra não cadastrada...")
			}	
		escreva("\n")
		Pressione_Enter()
	}

	funcao Listar_dados(cadeia matriz[][], inteiro contador, inteiro limite){
		inteiro contador1 = 0, contador2 = 0
		
		limpa()
		se (contador>0){
			para (contador1; contador1<limite; contador1++){
				se(matriz[contador1][0] != ""){	
					escreva("\nObra ", contador2+1, ":")
					Lista_dados_elemento(matriz, contador1)
					contador2++
				}
			}
		} 
		senao {
			escreva ("\nNenhuma obra foi registrada.\n")
		}
		escreva("\n\n")
		Pressione_Enter()
	}

	funcao Alterar_elemento(cadeia matriz[][], inteiro limite, inteiro contador){
		cadeia titulo, entrada, opcao
		inteiro contador1
		inteiro localizacao = -1, opcao_inteiro = -1

		limpa()
		escreva("--- ALTERAR ELEMENTO ---\n\n")
		escreva("Digite o título da obra que você deseja alterar:  ")
		leia(titulo)
		enquanto(Apenas_espacos(titulo)){
			escreva("\nDigite um titulo válido:\n")
			leia(titulo)
		}
		para(contador1=0; contador1<limite; contador1++){
			se(tx.caixa_baixa(matriz[contador1][0])==tx.caixa_baixa(titulo)){
				localizacao = contador1
			}			
		}
			se (localizacao > -1){
				limpa()
				escreva("Qual informação da obra cadastrada você deseja alterar? Digite o número correspondente: \n\n")
				escreva("1-Titulo da obra\n2-Nome do artista\n3-Ano de criação\n4-Material Utilizado\n5-Gênero artístico\n6-Cancelar a alteração\n\n")
				leia (opcao)
				enquanto(opcao_inteiro == -1){
						se (tp.cadeia_e_inteiro(opcao,10)){
							opcao_inteiro = tp.cadeia_para_inteiro(opcao, 10)		
							se (opcao_inteiro<1 ou opcao_inteiro>8){
								opcao_inteiro = -1
								escreva("\nDigite um número válido:\n")
								leia(opcao)
							}
						} 
						senao {
							escreva("\nDigite um número válido:\n")
							leia(opcao)
						}
				}			
				escolha (opcao_inteiro){
					caso 1: 
						limpa()
						escreva ("Digite o novo título da obra ", matriz[localizacao][0], ": ")
						leia(entrada)
						entrada = Verifica_titulo(matriz,entrada, limite, contador)
						matriz[localizacao][0] = entrada
						se (tx.caixa_baixa(matriz[localizacao][0]) == tx.caixa_baixa(entrada)){
							escreva("\nAlteração feita com sucesso.")
						} 
						pare				
					caso 2: 
						limpa()
						escreva ("Digite o novo nome do artista da obra ",matriz[localizacao][0],": ")
						leia(entrada)
						enquanto(Apenas_espacos(entrada) ou (tx.numero_caracteres(entrada)<3) ou (tp.cadeia_e_inteiro(entrada,10))){
							escreva("\nCampo inválido. Digite novamente: a partir de 3 caracteres.\n")
							leia(entrada)
						}
						matriz[localizacao][1] = entrada
						se (matriz[localizacao][1] == entrada){
							escreva("\nAlteração feita com sucesso.")
						}
						pare
					caso 3:
						limpa()
						escreva ("Digite o novo ano de criação da obra ",matriz[localizacao][0],": ")
						leia(entrada)
						enquanto(tp.cadeia_e_inteiro(entrada,10) == falso ou ((tp.cadeia_para_inteiro(entrada, 10)>2023) ou ((tp.cadeia_para_inteiro(entrada, 10)<1000))) ){
							escreva("\nCampo inválido. Digite novamente: apenas números inteiros de 1000 até 2023.\n")
							leia(entrada)
						}
						matriz[localizacao][2] = entrada
						se (matriz[localizacao][2] == entrada){
							escreva("\nAlteração feita com sucesso.")
						}
						pare	
					caso 4: 
						limpa()
						Escolhe_material(matriz, localizacao)
						escreva("\nAlteração feita com sucesso.")
						pare
					caso 5: 
						limpa()
						Escolhe_genero(matriz, localizacao)
						escreva("\nAlteração feita com sucesso.")
						pare
					caso 6:
						pare
				}							
			} 
			senao {
				
				escreva("\nObra não cadastrada...")		
			}	
		escreva("\n")
		Pressione_Enter()
	}

	funcao logico Excluir_elemento(cadeia matriz[][], inteiro limite){
		
		cadeia titulo_excluir
		inteiro contador1
		inteiro localizacao = -1

			limpa()
			escreva("***** EXCLUIR ELEMENTO *****\n\n")
			escreva("\nDigite o titulo do elemento que você deseja excluir.\n")
			leia(titulo_excluir)
			enquanto(Apenas_espacos(titulo_excluir)){
				escreva("\nCampo vazio. Digite novamente.\n")
				leia(titulo_excluir)
			}
			titulo_excluir = tx.caixa_baixa(titulo_excluir)
			para(contador1 = 0; contador1 < limite; contador1++){
				se(tx.caixa_baixa(matriz[contador1][0])==titulo_excluir){
					localizacao = contador1
				}			
			}
			se(localizacao > -1){
				para (contador1 = 0; contador1<5; contador1++){
					matriz[localizacao][contador1] = ""
				}
				escreva("\nObra excluída com sucesso.\n")
				Pressione_Enter()
				retorne verdadeiro
			}
			senao {
				escreva("\nObra não cadastrada...\n")
				Pressione_Enter()
				retorne falso
				}
			
		}
	
	funcao Gerar_relatorio(cadeia matriz[][], inteiro limite){
		cadeia opcao
		inteiro opcao_inteiro = -1, contador1, contador_relatorios = 0
		
		limpa()
		escreva("***** GERAR RELATÓRIO *****\n\n")
		escreva("Qual relatório você deseja gerar? Digite o número correspondente: \n\n")
		escreva("1-Obras realizadas com grafite\n2-Obras expressionistas\n3-Obras realizadas no ano de 2020\n\n")
		leia(opcao)
		enquanto(opcao_inteiro == -1){
						se (tp.cadeia_e_inteiro(opcao,10)){
							opcao_inteiro = tp.cadeia_para_inteiro(opcao, 10)		
							se (opcao_inteiro<1 ou opcao_inteiro>3){
								opcao_inteiro = -1
								escreva("\nDigite um número válido:\n")
								leia(opcao)
							}
						} 
						senao {
							escreva("\nDigite um número válido:\n")
							leia(opcao)
						}
				}
		escolha(opcao_inteiro){
			caso 1: 
				limpa()
				escreva("***** OBRAS REALIZADAS COM GRAFITE *****\n\n")
				para (contador1=0; contador1<limite; contador1++){
					se (matriz[contador1][3] == "Grafite"){
					Lista_dados_elemento(matriz,contador1)
					contador_relatorios++
					}
				}
				se(contador_relatorios == 0){
					escreva("\n\nNão existem obras realizadas com grafite cadastradas.\n")
				}
				pare
			caso 2:
				limpa()
				escreva("***** OBRAS EXPRESSIONISTAS *****\n\n")
				para (contador1=0; contador1<limite; contador1++){
					se (matriz[contador1][4] == "Expressionismo"){
						Lista_dados_elemento(matriz, contador1)
						contador_relatorios++
					}
				}
					se(contador_relatorios == 0){
						escreva("\n\nNão existem obras expressionistas cadastradas.\n")
				}	
				pare
			caso 3:
				limpa()
				escreva("***** OBRAS DE 2020 *****\n\n")
				para (contador1=0; contador1<limite; contador1++){
					se (matriz[contador1][2] == "2020"){
						Lista_dados_elemento(matriz, contador1)
						contador_relatorios++
					}
				}
				se(contador_relatorios == 0){
					escreva("\n\nNão existem obras do ano de 2020 cadastradas.\n")
				}
				pare
		} // fim escolha
		escreva ("\n\n\n")
		Pressione_Enter()
	}
	
	funcao Pressione_Enter(){
		cadeia pressione
		escreva("Pressione [ENTER] para voltar ao menu....")
		leia(pressione)
	}

	funcao Lista_dados_elemento(cadeia matriz[][], inteiro posicao){
				escreva("\n\nTitulo da obra: ", matriz[posicao][0], "\n")
				escreva("Nome do artista: ", matriz[posicao][1], "\n")
				escreva("Ano de criação: ", matriz[posicao][2], "\n")
				escreva("Material Utilizado: ", matriz[posicao][3], "\n")
				escreva("Gênero artístico: ", matriz[posicao][4], "\n")
				escreva("\n")
				escreva("*********************************************\n")
		}
		
	funcao inteiro Procura_primeira_linha(cadeia matriz[][], inteiro limite){
		inteiro linha_disponivel = -1
		inteiro contador 
		para (contador = 0; contador < limite ; contador++){
			se ((matriz[contador][0] ) == "") {
				linha_disponivel = contador
				pare
			}
			senao {
				linha_disponivel = -1
			}		
		} // fim para
		retorne linha_disponivel
	}

	funcao logico Apenas_espacos (cadeia string)
	{
		inteiro tamanho_string, contador, contador_espacos = 0
		logico var = verdadeiro

		tamanho_string = tx.numero_caracteres(string)
		para (contador = 0; contador<tamanho_string; contador++){
			se((tx.extrair_subtexto(string, contador, contador+1) != " ") ){
				var = falso
			}
		}
		retorne var	
	}

	funcao cadeia Verifica_titulo(cadeia matriz[][],cadeia titulo, inteiro limite, inteiro contador){
		inteiro contador_titulos
		
		enquanto(Apenas_espacos(titulo)){
						escreva("\nCampo vazio. Digite novamente\n")
						leia(titulo)
				}
				se (contador != 0){
					para (contador_titulos = 0; contador_titulos<contador; contador_titulos++){
						se (tx.caixa_baixa(matriz[contador_titulos][0]) == tx.caixa_baixa(titulo)){
							enquanto(tx.caixa_baixa(titulo) == tx.caixa_baixa(matriz[contador_titulos][0])) {
								escreva("Titulo já cadastrado. Escolha outro titulo: ")
								leia (titulo)
								enquanto(Apenas_espacos(titulo)){
									escreva("\nCampo vazio. Digite novamente\n")
									leia(titulo)
								} 
							} 
						}	
					}
				}
				
		retorne titulo
	}
	
	funcao Escolhe_material (cadeia matriz[][], inteiro posicao){
		
		cadeia opcao, material_utilizado
		inteiro opcao_inteiro = -1
		
		escreva("\nMaterial utilizado (digite o número correspondente): \n\n")
		escreva("1-Grafite\n2-Carvão\n3-Lápis de cor\n4-Aquarela\n5-Tinta acrílica\n6-Tinta a óleo\n7-Giz de cera\n8-Outro\n\n")
		leia(opcao)
		enquanto(opcao_inteiro == -1){
			se (tp.cadeia_e_inteiro(opcao,10)){
				opcao_inteiro = tp.cadeia_para_inteiro(opcao, 10)		
				se (opcao_inteiro<1 ou opcao_inteiro>8){
					opcao_inteiro = -1
					escreva("\nDigite um número válido:\n")
					leia(opcao)
				}
			} 
				senao {
						escreva("\nDigite um número válido:\n")
						leia(opcao)
				}
		}							
		escolha(opcao_inteiro){
			caso 1:
				matriz[posicao][3] = "Grafite"
				pare
			caso 2:
				matriz[posicao][3] = "Carvão"
				pare
			caso 3:
				matriz[posicao][3] = "Lápis de cor"
				pare
			caso 4:
				matriz[posicao][3] = "Aquarela"
				pare
			caso 5:
				matriz[posicao][3] = "Tinta acrílica"
				pare
			caso 6:
				matriz[posicao][3] = "Tinta a óleo"
				pare
			caso 7:
				matriz[posicao][3] = "Giz de cera"
				pare
			caso 8:
				escreva("\nDigite o material utilizado: \n")
				leia(material_utilizado)
				enquanto(Apenas_espacos(material_utilizado) ou tp.cadeia_e_inteiro(material_utilizado,10)){
					escreva("\nCampo inválido. Digite novamente.\n")
					leia(material_utilizado)
				}
				matriz[posicao][3] = material_utilizado
				pare
		}// fim escolha
	}
	
	funcao Escolhe_genero (cadeia matriz[][], inteiro posicao){
		cadeia opcao, genero
		inteiro opcao_inteiro
		escreva("\nGênero artístico: digite o número correspondente: \n\n")
		escreva("1-Expressionismo\n2-Realismo\n3-Surrealismo\n4-Dadaísmo\n5-Modernismo\n6-Cubismo\n7-Impressionismo\n8-Fauvismo\n9-Renascentismo\n10-Outro\n")
		leia(opcao)
		opcao_inteiro = -1
		enquanto(opcao_inteiro == -1){
				se (tp.cadeia_e_inteiro(opcao,10)){
					opcao_inteiro = tp.cadeia_para_inteiro(opcao, 10)		
					se (opcao_inteiro<1 ou opcao_inteiro>10){
						opcao_inteiro = -1
						escreva("\nDigite um número válido:\n")
						leia(opcao)
							}
				} 
				senao {
					escreva("\nDigite um número válido:\n")
					leia(opcao)
				}
		} 
		escolha(opcao_inteiro){
			caso 1: 
				matriz[posicao][4] = "Expressionismo"
				pare
			caso 2: 
				matriz[posicao][4] = "Realismo"
				pare
			caso 3: 
				matriz[posicao][4] = "Surrealismo"
				pare
			caso 4: 
				matriz[posicao][4] = "Dadaísmo"
				pare
			caso 5: 
				matriz[posicao][4] = "Modernismo"
				pare
			caso 6: 
				matriz[posicao][4] = "Cubismo"
				pare
			caso 7: 
				matriz[posicao][4] = "Impressionismo"
				pare
			caso 8: 
				matriz[posicao][4] = "Fauvismo"
				pare
			caso 9: 
				matriz[posicao][4] = "Renascentismo"
				pare
			caso 10:
				escreva("\nDigite o gênero da obra: \n")
				leia(genero)
				enquanto(Apenas_espacos(genero) ou tp.cadeia_e_inteiro(genero,10)){
					escreva("\nCampo inválido. Digite novamente.\n")
					leia(genero)
				}
				matriz[posicao][4] = genero
				pare
		} // fim escolha
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 6389; 
 * @DOBRAMENTO-CODIGO = [8, 52, 150, 370, 386, 401, 440, 496];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz;
 */