lapis = require "lapis"

import respond_to, json_params from require "lapis.application"

Systems = require "models.Systems"

class extends lapis.Application
    [get_system: "/get_system"]: respond_to {
        GET: =>
            return status: 405

        POST: json_params =>
            if @params.x and @params.y
                if system = Systems\find x: @params.x, y: @params.y
                    return json: { status: "discovered", :system }
                else
                    system = Systems\create {
                        name: @params.name
                        x: @params.x
                        y: @params.y
                        seed: @params.seed
                    }
                    return json: { status: "undiscovered", :system }

            return json: { status: "failure" }
    }

    [post_system: "/post_system"]: respond_to {
        GET: =>
            return status: 405

        POST: json_params =>
            if @params.name and @params.x and @params.y and @params.seed
                if system = Systems\find x: @params.x, y: @params.y
                    unless system.uploaded
                        system\update {
                            name: @params.name
                        }
                        return json: { status: "success" }

            return json: { status: "failure" }
    }
