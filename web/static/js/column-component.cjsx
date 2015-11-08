
class ColumnComponent extends React.Component

  render: ->
    <div className="col" style={{width: "#{@props.column_width}px"}}>
      <div className="left-padding" style={{width: "#{@props.column_padding}px"}}>
      </div>
      <div className="right-padding" style={{width: "#{@props.column_padding}px"}}>
      </div>
    </div>

module.exports = ColumnComponent