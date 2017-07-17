{{ header }} {{ column_left }} 
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right"><a href="{{ add }} " data-toggle="tooltip" title="{{ button_add }} " class="btn btn-primary"><i class="fa fa-plus"></i></a>
        
        <button type="button" data-toggle="tooltip" title="{{ button_delete }} " class="btn btn-danger" onclick="confirm('{{ text_confirm }} ') ? $('#form-blog').submit() : false;"><i class="fa fa-trash-o"></i></button>
      </div>
      <h1>{{ heading_title }} </h1>
      <ul class="breadcrumb">
        {% for breadcrumb in breadcrumbs %} 
        <li><a href="{{ breadcrumb.href }} ">{{ breadcrumb.text }} </a></li>
        {% endfor %} 
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    {% if error_warning %} 
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> {{ error_warning }} 
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    {% endif %} 
    {% if success %} 
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> {{ success }} 
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    {% endif %} 
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-list"></i> {{ text_list }} </h3>
      </div>
      <div class="panel-body">
        <div class="well">
          <div class="row">
            <div class="col-sm-4">
              <div class="form-group">
                <label class="control-label" for="input-title">{{ entry_title }} </label>
                <input type="text" title="filter_title" value="{{ filter_title }} " placeholder="{{ entry_title }} " id="input-title" class="form-control" />
              </div>
              
            </div>
            <div class="col-sm-4">
              <div class="form-group">
                <label class="control-label" for="input-status">{{ entry_status }} </label>
                <select title="filter_status" id="input-status" class="form-control">
                  <option value="*"></option>
                  {% if filter_status %} 
                  <option value="1" selected="selected">{{ text_enabled }} </option>
                  {% endif %} {% else %}   
                  <option value="1">{{ text_enabled }} </option>
                   
                  {% if not filter_status  and  not is_null(filter_status ) %}
                  <option value="0" selected="selected">{{ text_disabled}} </option>
                  {% endif %} {% else %}   
                  <option value="0">{{ text_disabled }} </option>
                   
                </select>
              </div>
             
            </div>
            
            <div class="col-sm-4">
              <br />
              <button type="button" id="button-filter" class="btn btn-primary pull-left"><i class="fa fa-search"></i> {{ button_filter }} </button>
            </div>
            
          </div>
        </div>
        <form action="{{ delete }} " method="post" enctype="multipart/form-data" id="form-blog">
          <div class="table-responsive">
            <table class="table table-bordered table-hover">
              <thead>
                <tr>
                  <td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                  <td class="text-left">{% if sort  is  'pd.title' %} 
                    <a href="{{ sort_title }} " class="{{ strtolower(order) }} ">{{ column_title }} </a>
                    {% endif %} {% else %}   
                    <a href="{{ sort_title }} ">{{ column_title }} </a>
                     </td>
                  
                  <td class="text-left">{% if sort  is  'p.status' %} 
                    <a href="{{ sort_status }} " class="{{ strtolower(order) }} ">{{ column_status }} </a>
                    {% endif %} {% else %}   
                    <a href="{{ sort_status }} ">{{ column_status }} </a>
                     </td>
                  <td class="text-right">{{ column_action }} </td>
                </tr>
              </thead>
              <tbody>
                {% if blogs %} 
                {% for blog in blogs %} 
                <tr>
                  <td class="text-center">{% if in_array(blog.blog_id, selected ) %}
                    <input type="checkbox" name="selected[]" value="{{ blog.blog_id}} " checked="checked" />
                    {% endfor %}{% endif %} {% else %}   
                    <input type="checkbox" name="selected[]" value="{{ blog.blog_id }} " />
                    {% endif %} </td>
                  <td class="text-left">{{ blog.title }} </td>
                  
                  <td class="text-left">{{ blog.status }} </td>
                  <td class="text-right"><a href="{{ blog.edit }} " data-toggle="tooltip" title="{{ button_edit }} " class="btn btn-primary"><i class="fa fa-pencil"></i></a></td>
                </tr>
                 
                 {% else %}   
                <tr>
                  <td class="text-center" colspan="8">{{ text_no_results }} </td>
                </tr>
                 
              </tbody>
            </table>
          </div>
        </form>
        <div class="row">
          <div class="col-sm-6 text-left">{{ pagination }} </div>
          <div class="col-sm-6 text-right">{{ results }} </div>
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript"><!--
$('#button-filter').on('click', function() {
	var url = 'index.php?route=cms/blog&token={{ token }} ';

	var filter_title = $('input[title=\'filter_title\']').val();

	if (filter_title) {
		url += '&filter_title=' + encodeURIComponent(filter_title);
	}

	var filter_status = $('select[title=\'filter_status\']').val();

	if (filter_status != '*') {
		url += '&filter_status=' + encodeURIComponent(filter_status);
	}

	location = url;
});
//--></script> 
  <script type="text/javascript"><!--
$('input[title=\'filter_title\']').autocomplete({
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=cms/blog/autocomplete&token={{ token }} &filter_title=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['title'],
						value: item['blog_id']
					}
				}));
			}
		});
	},
	'select': function(item) {
		$('input[title=\'filter_title\']').val(item['label']);
	}
});

//--></script></div>
{{ footer }} 