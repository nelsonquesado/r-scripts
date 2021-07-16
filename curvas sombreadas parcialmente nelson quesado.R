# Este script foi desenvolvido por Nelson de Oliveira Quesado Filho em Julho de
# 2021 (Quesado Filho, N. O.)

# Este gráfico é produzido utilizando a biblioteca GGPLOT.
# O ggplot utiliza o método de sobreposição de camadas para construção dos
# gráficos. As camadas são separadas pelo argumento +
# Utiliza-se aqui as funções qnorm, dnorm e pnorm. Existem funções similares
# para outras distribuições conhecidas como o pchisq, pexp, ppois e o pt.
# Utilize o argumetno ? antes da função para obter ajuda.

# biblitecas utilizadas
library(tidyverse)

# curva normal
# eixo x fixo entre -3 e 3
# eixo y fixo entre 0 e 0.5
ggplot() +
  geom_density(aes(qnorm(seq(.001, .999, .01)))) +
  xlim(-3, 3) +
  ylim(0, .5)
  
# curva normal +
# eixo x fixo entre -3 e 3 +
# eixo y fixo entre 0 e 0.5 +
# Linhas verticais 5% e 95% +
# tema minimal
ggplot() +
  geom_density(aes(qnorm(seq(.001, .999, .01)))) +
  xlim(-3, 3) +
  ylim(0, .5) +
  geom_vline(xintercept = qnorm(0.05)) +
  geom_vline(xintercept = qnorm(0.95)) +
  theme_minimal()

# curva normal completamente sobreada na cor #FC0D85 com transparência de 30%
# eixo x fixo entre -3 e 3 +
# eixo y fixo entre 0 e 0.5 +
# Linhas verticais 5% e 95% +
# tema minimal
ggplot() +
  geom_density(aes(qnorm(seq(.001, .999, .01))), fill = "#FC0D85", alpha = .3) +
  xlim(-3, 3) +
  ylim(0, .5) +
  geom_vline(xintercept = qnorm(0.05)) +
  geom_vline(xintercept = qnorm(0.95)) +
  theme_minimal()


# curva normal parcialmente sobreada (+- 45%) na cor #FC0D85 com transparência de 30%
# eixo x fixo entre -3 e 3 +
# eixo y fixo entre 0 e 0.5 +
# Linhas verticais 5% e 95% +
# Ajustes de legendas
# tema minimal

# Cria-se um objeto para representar o eixo x
eixo_x <- ifelse(
  qnorm(seq(.001, .999, .001)) < qnorm(.05), qnorm(.05), #limite inferior da sombra (5%)
  ifelse(
    qnorm(seq(.001, .999, .001)) > qnorm(.95), qnorm(.95), #limite superior da sombra (95%)
    qnorm(seq(.001, .999, .001))
  )
)

# Cria-se um objeto para representar o eixo y
eixo_y <- dnorm(eixo_x)

# Cria-se a curva completa
curva <- data.frame(x = qnorm(seq(.001, .999, length = length(eixo_x))), y = dnorm(qnorm(seq(.001, .999, length = length(eixo_x)))))

# Plota-se o gráfico com duas curvas
ggplot() +
  geom_line(aes(x = curva$x, y = curva$y)) +
  geom_area(aes(eixo_x, eixo_y, fill = "#FC0D85"), alpha = .3) +
  xlim(-3, 3) +
  ylim(0, .5) +
  geom_vline(xintercept = qnorm(0.05)) +
  geom_vline(xintercept = qnorm(0.95)) +
  labs(title = "Tutorial Curva Normal Parcialmente Sombreada", subtitle = "Pode ser adaptada para outras curvas", x = "Score Z", y = "Probabilidade") +
  scale_fill_identity(name = "Legenda", breaks = c("#FC0D85"), labels = c("Intervalo de Confiança"), guide ="legend") +
  theme_minimal()
