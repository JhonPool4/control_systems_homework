function add_datatip(r_fig, datatip_index, x_data, y_data, label_list, location)

    dt = datatip(r_fig, x_data(datatip_index), y_data(datatip_index) );
    dt.Location = location;
    dt.FontSize = 8;
    dt.Interpreter = 'latex';

    r_fig.DataTipTemplate.DataTipRows(1).Label = label_list{1};
    r_fig.DataTipTemplate.DataTipRows(2).Label = label_list{2};
end