using Plots
using LinearAlgebra # Necessário para o operador \ (resolução de sistema)

# 1. Função de Runge: Desafio Clássico da Interpolação
f(x) = 1.0 / (1.0 + 25.0 * x^2)

# 2. Intervalo de plotagem
x_plot = range(-1.0, 1.0, length = 200)

# 3. Criação do Objeto de Animação
# A animação irá variar o número de pontos de interpolação (N) de 3 a 17.
animation = @animate for N in 3:2:17 
    
    # Define os pontos de interpolação igualmente espaçados
    X = range(-1.0, 1.0, length = N)
    Y = f.(X)

    # Calcula a Matriz de Vandermonde (similar ao 2110.jl)
    # V[i, j] = X[i]^(j-1)
    V = [X[i]^(j-1) for i in 1:N, j in 1:N]
    
    # Resolve o sistema linear V * a = Y para encontrar os coeficientes 'a'
    a = V \ Y

    # Função para avaliar o Polinômio P(x)
    # P(x) = a[1]*x^0 + a[2]*x^1 + a[3]*x^2 + ...
    P(x) = sum(a[j] * x^(j-1) for j in 1:N)
    
    y_interp = P.(x_plot)

    # 4. Configura e Plota o Frame
    plot(x_plot, f.(x_plot), 
         label = "Função Original: \$f(x) = 1 / (1 + 25x^2)\$", 
         line = (:dash, 2, :black),
         title = "Interpolação Polinomial (N = $N Pontos)", 
         xlabel = "Eixo x", 
         ylabel = "Eixo y",
         xlims = (-1.05, 1.05),
         ylims = (0, 1.1),
         legend = :bottom)
         
    plot!(x_plot, y_interp, 
          label = "Polinômio Interpolador", 
          linewidth = 3,
          color = :blue)
          
    scatter!(X, Y, 
             label = "Pontos de Interpolação", 
             markersize = 4, 
             color = :red)
end

# 5. Salva a animação como um GIF
# O 'fps = 1' (frames por segundo) define a velocidade da transição.
gif(animation, "interpolacao_animada.gif", fps = 1)