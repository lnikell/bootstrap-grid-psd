
ColumnComponent = require "./column-component"
class ConfiguratorComponent extends React.Component
  constructor: (props) ->
    super props
    @state = @getState()
  
  getState: ->
    {
      columns: 12
      max_width: 1170
      column_padding: 15
    }
  
  handleInputs: (e) =>
    params = {}
    params[e.target.name] = e.target.value
    @setState params


  componentWillMount: =>
    @calculate(@state)

  componentWillUpdate: (nextProps, nextState) =>
    @calculate(nextState)

  calculate: (state) =>
    console.log "calculate"
    column_width = Math.floor(state.max_width / state.columns)
    @column_params = 
      column_width: column_width
      column_padding: state.column_padding
    @actual_width = column_width * state.columns 
    
    @gridGuides = []

    for num in [0..@state.columns]
      offset = num * column_width
      @gridGuides.push offset - 15 if num != 0
      @gridGuides.push offset
      @gridGuides.push offset + 15 if num != @state.columns


  render: ->
    <div className="configurator-container">
      <div className="controls">
        <div className="container">
        <div className="row">
          <div className="control col-lg-2">
            <label>Max width of container</label>
            <input type="number" min="1" name="max_width" value={@state.max_width} onChange={@handleInputs}/>
          </div>
          
          <div className="control col-lg-2">
            <label>Columns</label>
            <input type="number" min="1" name="columns" value={@state.columns} onChange={@handleInputs}/>
          </div>

          <div className="control col-lg-2">
            <label>Padding of column</label>
            <input type="number" min="1" name="column_padding" value={@state.column_padding} onChange={@handleInputs}/>
          </div>
          <div className="control col-lg-3">
            { 
              extraClass = if @state.max_width > @actual_width then "less" else " " 
              <label>
                Actual width: 
                <span className="actual-width-value #{extraClass}">{@actual_width}px</span>
                <span className="information">
                  <div className="tooltip">
                    When you are setting the parameters it's not always possible to calculate the column size so it will be integer. Since working with integer grid is more convenient in Photoshop, we find the optimal container's width such that it's possible to calculate integer width of columns.
                  </div>
                </span>
              </label>
            }
          </div>
        </div>
        <div className="actions">
          <a className="button" href="/generate_grid?grid_guides=[#{@gridGuides}]">Generate for Adobe Photoshop</a>
        </div>
        </div>
      </div>
      <div className="grid-preview">
        <div className="photoshop-border"></div>
        <div className="grid-wrap" style={{width: "#{@actual_width}px"}}>
        {
          for num in [1..@state.columns]
            <ColumnComponent key={num} {...@column_params}/>
        }
        </div>
      </div>
      
    </div>

module.exports = ConfiguratorComponent