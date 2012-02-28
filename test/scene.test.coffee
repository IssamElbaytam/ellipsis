describe "scene", ->
    vis = null
    scene = null
    f = null
    a = null
    
    beforeEach ->
        vis = n3.vis('sceneTest')
                    .state('state_1', ['valid', 'values'])
                    .state('state_2', [true, false])
                    
        f = ->
            console.log('hello')

        a = n3.annotation('f')
                .adder(f)
                    
    it "sets the state", ->
        scene = n3.scene('scene_1')
                    .set(vis, 'state_1', 'valid')
                    .set('sceneTest', 'state_2', false)
                    
        expect(scene.members[0].vis).toBe vis
        expect(scene.members[0].state.id).toBe 'state_1'
        expect(scene.members[0].state.value).toBe 'valid'
        
        expect(scene.members[1].vis).toBe vis
        expect(scene.members[1].state.id).toBe 'state_2'
        expect(scene.members[1].state.value).toBe false
        
    it "adds members", ->            
        scene = n3.scene('scene_2')
                    .add(vis, f)
                    .add(vis, a)
                        
        expect(scene.members[0].vis).toBe vis
        expect(scene.members[0].member).toBe f

        expect(scene.members[1].vis).toBe vis
        expect(scene.members[1].member).toBe a
        
    it "clones a scene", ->
        scene = n3.scene('scene_3')
                    .set(vis, 'state_1', 'value')
                    .add(vis, f)
                    .set(vis, 'state_2', true)
                    
        scene2 = scene.clone('scene_4')
                        .add('sceneTest', a)
                        
        expect(scene2.members[0].vis).toEqual vis
        expect(scene2.members[0].state.id).toBe 'state_1'
        expect(scene2.members[0].state.value).toBe 'value'
        
        expect(scene2.members[1].vis).toEqual vis
        expect(scene2.members[1].member).toBe f
        
        expect(scene2.members[2].vis).toEqual vis
        expect(scene2.members[2].state.id).toBe 'state_2'
        expect(scene2.members[2].state.value).toBe true
        
        expect(scene2.members[3].vis).toEqual vis
        expect(scene2.members[3].member).toBe a
        
    it "is a subscene", ->
        scene = n3.scene('scene_4')
                    .set(vis, 'state_1', 'value')
                    .add(vis, f)
                    
        subScene = scene.subScene('scene_4a')
                            .set(vis, 'state_2', true)
                            .add(vis, a)
                            
        expect(subScene.parent).toBe scene
        
        expect(subScene.members[0].vis).toBe vis
        expect(subScene.members[0].state.id).toBe 'state_2'
        expect(subScene.members[0].state.value).toBe true
        
        expect(subScene.members[1].vis).toBe vis
        expect(subScene.members[1].member).toBe a
        