
function love.load()
    
    enemy11 = 0
    enemys = {}
    --everyshape--
    shapes_draw_a_colider = {}
    shapes_draw_a_colider.rectangle1 = {}
    shapes_draw_a_colider.rectangle2 = {}
    shapes_draw_a_colider.rectangle3 = {}
    --shape1--
    shapes_draw_a_colider.rectangle1.x = 0
    shapes_draw_a_colider.rectangle1.y = 170
    shapes_draw_a_colider.rectangle1.w = 800
    shapes_draw_a_colider.rectangle1.h = 8
    --shape2--
    shapes_draw_a_colider.rectangle2.x = 0
    shapes_draw_a_colider.rectangle2.y = 270
    shapes_draw_a_colider.rectangle2.w = 800
    shapes_draw_a_colider.rectangle2.h = 8
    --shape3--
    shapes_draw_a_colider.rectangle3.x = 0
    shapes_draw_a_colider.rectangle3.y = 250+120
    shapes_draw_a_colider.rectangle3.w = 800
    shapes_draw_a_colider.rectangle3.h = 8
    --player--
    shapes_draw_a_colider.player = {}
    shapes_draw_a_colider.player.x = 100
    shapes_draw_a_colider.player.y = 0
    shapes_draw_a_colider.player.w = 40
    shapes_draw_a_colider.player.h = 40
    shapes_draw_a_colider.player.health = 10
    shapes_draw_a_colider.player.sprite = love.graphics.newImage("sprites/AxolotlPlayer.png")
    shapes_draw_a_colider.player.sprite:setFilter("nearest")
    --list--
    move = 2
    shapes_draw_a_colider.player.movelist = {170,270,370}
    --levels/spawn--
    enemy_spawn = {}
    enemy_spawn.spawnw = {2,1.2,01,0.8,0.6,0.6,0.4,0.5}
    enemy_spawn.spawww = {1,0.8,0.6,0.4,0.5,0.4,0.2,0.4}
    enemy_spawn.spawns = {2,3,5,5,6,8,10,12,13,14,16,17}
    enemy_spawn.upgrade = {8,12,17,25,50,70,80,20,10000000000000000000000000000}
    enemy_spawn.timer = 0
    enemy_spawn.timer2 = 0
    enemy_spawn.next = 1


    create_enemy(1)
end

function love.draw()
    --lines--
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill",shapes_draw_a_colider.rectangle1.x,shapes_draw_a_colider.rectangle1.y,shapes_draw_a_colider.rectangle1.w,shapes_draw_a_colider.rectangle1.h)
    love.graphics.rectangle("fill",shapes_draw_a_colider.rectangle2.x,shapes_draw_a_colider.rectangle2.y,shapes_draw_a_colider.rectangle2.w,shapes_draw_a_colider.rectangle2.h)
    love.graphics.rectangle("fill",shapes_draw_a_colider.rectangle3.x,shapes_draw_a_colider.rectangle3.y,shapes_draw_a_colider.rectangle3.w,shapes_draw_a_colider.rectangle3.h)
    --player--
    love.graphics.setColor(0,0.5,1)

    love.graphics.rectangle("fill",shapes_draw_a_colider.player.x,shapes_draw_a_colider.player.y - 15,shapes_draw_a_colider.player.w,shapes_draw_a_colider.player.h)
    love.graphics.setColor(1,1,1)
    if test == 1 then
    love.graphics.draw(shapes_draw_a_colider.player.sprite,shapes_draw_a_colider.player.x-15,shapes_draw_a_colider.player.y-22,0,1.9,1.9)
    end
    --clone-------------------------------------------------------------------------------
love.graphics.setColor(1,0,0)
for i,c in ipairs(enemys) do
    if c.alive == "true" then
        if c.iscoin == 1 then
            love.graphics.setColor(0,1,0.8)
            c.x = c.x - enemy_spawn.spawns[enemy_spawn.next]
            love.graphics.rectangle("fill",c.x,c.y,c.w,c.h)

            if AABB(shapes_draw_a_colider.player.x,shapes_draw_a_colider.player.y,shapes_draw_a_colider.player.w,shapes_draw_a_colider.player.h,c.x,c.y,c.w,c.h) then
                table.remove(enemys,i)
                c.alive = "false"
                shapes_draw_a_colider.player.health = shapes_draw_a_colider.player.health + 1  
            end

            if AABB(-10,0,10,5000,c.x,c.y,c.w,c.h) then
                table.remove(enemys,i)
                c.alive = "false"
            end

        else
        love.graphics.setColor(1,0,0)
        c.x = c.x - enemy_spawn.spawns[enemy_spawn.next]
        love.graphics.rectangle("fill",c.x,c.y,c.w,c.h)
    

    if AABB(shapes_draw_a_colider.player.x,shapes_draw_a_colider.player.y,shapes_draw_a_colider.player.w,shapes_draw_a_colider.player.h,c.x,c.y,c.w,c.h) then
        shapes_draw_a_colider.player.health = shapes_draw_a_colider.player.health - 1
        table.remove(enemys,i)
        c.alive = "false"
    end

    if AABB(-10,0,10,5000,c.x,c.y,c.w,c.h) then
        
        table.remove(enemys,i)
        c.alive = "false"
    end
end
end
end

--clone---------------------------------------------------------------------------------------
--gui--
local windowwidth, windowheight = love.graphics.getDimensions( )
local font = love.graphics.setNewFont("Sono-Regular.ttf", 22)
love.graphics.setColor(1,0,0)
love.graphics.print(enemy_spawn.next,0,0)
love.graphics.setColor(0.3,1,0.1,0.9)

local font = love.graphics.setNewFont("Sono-Regular.ttf", 50)
love.graphics.print(shapes_draw_a_colider.player.health,windowwidth/2,10)
end

function love.update(dt)
    --player x movement--
        if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
            shapes_draw_a_colider.player.x = shapes_draw_a_colider.player.x - 8
        end

        if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
            shapes_draw_a_colider.player.x = shapes_draw_a_colider.player.x + 8
    end

    --player x movement--

    --player move--
    if move > 3 then 
        move = 1
    end
    if move < 1 then 
        move = 3
    end
    --player move--

    shapes_draw_a_colider.player.y = shapes_draw_a_colider.player.movelist[move]

    enemy_spawn.timer = enemy_spawn.timer + 1*dt
    enemy_spawn.timer2 = enemy_spawn.timer2 + 1*dt

    local set = love.math.random(enemy_spawn.spawnw[enemy_spawn.next],enemy_spawn.spawww[enemy_spawn.next])

    if enemy_spawn.timer >= set then
        create_enemy(1)
        enemy_spawn.timer = 0
    end

    if enemy_spawn.timer2 >= enemy_spawn.upgrade[enemy_spawn.next] then
        enemy_spawn.next = enemy_spawn.next + 1
        enemy_spawn.timer2 = 0
    end

    if shapes_draw_a_colider.player.health < 1 then
        love.event.quit()
    end



end

function love.keypressed(key, scancode, isrepeat)
    if key == "w" or key == "up" then
       move = move - 1
    end

    if key == "s" or key == "down" then
        move = move + 1
     end

     if key == "p" or key == "space" then
        
        create_enemy(1)
     end

     if key == "]" then
        test = 1
     end
     if key == "[" then
     test = 0
    end
 end


 
 function create_enemy(amount)
    
    for i=1,1 do 
        enemy = {}
        enemy.iscoin = love.math.random(1,6)
        enemy.x = 770
        enemy.y = shapes_draw_a_colider.player.movelist[love.math.random(1,3)] - 12
        enemy.w = 30
        enemy.h = 30
        enemy.alive = "true"

        table.insert(enemys,enemy)
    end
 end

 function AABB(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2 + w2 and
           x1 + w1 > x2 and
           y1 < y2 + h2 and
           y1 + h1 > y2
end


 