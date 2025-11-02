using Plots

# 1. Definição da Função 3D (Função Sombrero/Mexican Hat)
# Uma função clássica para visualizações 3D que cria picos e vales circulares.
# f(r) = sin(k*r) / (k*r), onde r é a distância da origem.
function sombrero_function(x, y)
    # Distância Euclidiana da origem
    r = sqrt(x^2 + y^2)
    # Constante para controlar a frequência das ondas
    k = 8
    
    if r == 0.0
        return 1.0  # Limite da função para r -> 0 é 1.0
    else
        return sin(r * k) / (r * k)
    end
end

# 2. Definição do Domínio e da Superfície Z
# Grid 50x50 no intervalo [-2, 2]
X_range = range(-2, 2, length=50)
Y_range = range(-2, 2, length=50)

# Calcula o valor Z para cada ponto (x, y) da grade
Z = [sombrero_function(x, y) for x in X_range, y in Y_range]

# 3. Criação do Objeto de Animação
# Variamos o ângulo de Azimute da câmera de 0 a 360 graus.
animation = @animate for angle in range(0, 360, length=72)
    
    # Plota a Superfície 3D
    surface(X_range, Y_range, Z,
            # Configuração da Câmera: (Elevação, Azimute)
            camera = (30, angle), # 30 graus de elevação fixa, ângulo horizontal rotaciona.
            
            # Títulos e Rótulos
            title = "Superfície 3D em Rotação",
            zlabel = "\$f(x, y)\$",
            xlabel = "\$x\$",
            ylabel = "\$y\$",
            
            # Aparência
            colorbar = false,
            seriescolor = :viridis, # Paleta de cores moderna
            legend = false,
            linecolor = :gray,
            linewidth = 0.1,
            grid = true
            )
end

# 4. Salva a animação como um GIF
# fps = 20 garante uma rotação suave.
gif(animation, "superficie_3d_rotacao.gif", fps = 20)