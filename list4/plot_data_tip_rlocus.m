function [data_index]= plot_data_tip_rlocus(r_data, kp_data, kd_data, r_fig)
    data_index = find(real(r_data)>=0, 1);
    
    dt = datatip(r_fig, real(r_data(data_index)), imag(r_data(data_index)) );
    dt.Location = 'southwest';
    dt.FontSize = 6;
    
    r_fig.DataTipTemplate.DataTipRows(1).Label = 'Re: ';
    r_fig.DataTipTemplate.DataTipRows(2).Label = 'Im: ';
    r_fig.DataTipTemplate.DataTipRows(1).Format = '%.2f'; % x
    r_fig.DataTipTemplate.DataTipRows(2).Format = '%.2f'; % x
    
    row_kp = dataTipTextRow('KP:',kp_data,'%#4.3g');
    row_kd = dataTipTextRow('KD:',kd_data,'%#4.3g');
    r_fig.DataTipTemplate.DataTipRows(end+1) = row_kp;
    r_fig.DataTipTemplate.DataTipRows(end+1) = row_kd;

end