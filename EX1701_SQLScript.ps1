/*
m3_vil_div
m3_vil_div_his
vil_accuse_no_code
vil_accuse_state_code
ii 'H:\TPTAODB\20160117\vil_accuse_type_code.H'
ii 'H:\TPTAODB\20160117\vil_addr_no_code.H'
ii 'H:\TPTAODB\20160117\vil_adj_traffic.H' ;notepad 'H:\TPTAODB\20160117\vil_adj_traffic.D'
vil_adm_handle_code
vil_adm_remedy_log
vil_adm_state_code
vil_car_kind_code
vil_car_susp_code
vil_car_susp_his
vil_clause_rule
vil_close_code
vil_div_detail
vil_dmv_code
vil_drv_susp_code
vil_hold_code
ii 'H:\TPTAODB\20160117\vil_law_close_status_code.H' ;notepad 'H:\TPTAODB\20160117\vil_law_close_status_code.D'
vil_law_compete
vil_lic_type
vil_migrate
vil_motor_susp_his
vil_pay_month
vil_pay_month_detail
vil_pay_way_code
vil_phone_xact
vil_plate_susp_his
vil_query_log
vil_rcv_state_code
vil_receipt_payment
vil_traffic_rule
vil_vehicle_kind_code
*/


USE [TAODB_CSQ]
GO

/****** Object:  Table [dbo].[ztranslog]    Script Date: 5/26/2016 2:26:51 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[ztranslog](
	[iid] [int] IDENTITY(1,1) NOT NULL,
	[importDT] [char](10) NULL,
	[Tablename] [nvarchar](100) NULL,
	[fromdcb] [int] NULL,
	[insertSQL] [int] NULL,
	[countSum] [int] NULL,
	[checkflag] [nvarchar](20) NULL,
	[modifydt] [datetime] NULL,
	[TotalMinutes] [float] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO




/****** Object:  Table [dbo].[m3_vil_div]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[m3_vil_div](
	[plate_no] [nchar](15) NULL,
	[id_no] [nchar](10) NULL,
	[vil_ticket] [nchar](11) NULL,
	[name] [nchar](120) NULL,
	[apply_date] [date] NULL,
	[end_date] [date] NULL,
	[installments] [int] NULL,
	[is_first_wine_case] [nchar](1) NULL,
	[total_penalty] [int] NULL,
	[create_uid] [nchar](20) NULL,
	[create_dmv] [nchar](2) NULL,
	[update_date] [date] NULL,
	[update_uid] [nchar](20) NULL,
	[update_dmv] [nchar](2) NULL,
	[installment_plan] [nchar](1) NULL,
	[update_dt] [datetime] NULL,
	[car_plate_no] [nchar](10) NULL,
	[installment_doc] [nchar](90) NULL,
	[tel_day] [nchar](26) NULL,
	[zip] [nchar](5) NULL,
	[addr] [nchar](120) NULL
) ON [PRIMARY]

GO




/****** Object:  Table [dbo].[m3_vil_div_his]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[m3_vil_div_his](
	[plate_no] [nchar](15) NULL,
	[id_no] [nchar](10) NULL,
	[vil_ticket] [nchar](11) NULL,
	[name] [nchar](120) NULL,
	[apply_date] [date] NULL,
	[end_date] [date] NULL,
	[installments] [int] NULL,
	[is_first_wine_case] [nchar](1) NULL,
	[total_penalty] [int] NULL,
	[create_uid] [nchar](20) NULL,
	[create_dmv] [nchar](2) NULL,
	[update_date] [date] NULL,
	[update_uid] [nchar](20) NULL,
	[update_dmv] [nchar](2) NULL,
	[installment_plan] [nchar](1) NULL,
	[update_dt] [datetime] NULL,
	[car_plate_no] [nchar](10) NULL,
	[installment_doc] [nchar](90) NULL,
	[tel_day] [nchar](26) NULL,
	[zip] [nchar](5) NULL,
	[addr] [nchar](120) NULL
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[vil_accuse_no_code]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_accuse_no_code](
	[accuse_no] [nchar](5) NOT NULL,
	[accuse_name] [nchar](45) NULL,
	[accuse_phone] [nchar](12) NULL,
PRIMARY KEY CLUSTERED 
(
	[accuse_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[vil_accuse_state_code]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_accuse_state_code](
	[accuse_state] [nchar](2) NULL,
	[accuse_error_reason] [nchar](24) NULL
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[vil_accuse_type_code]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_accuse_type_code](
	[accuse_type] [nchar](2) NOT NULL,
	[accuse_type_name] [nchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[accuse_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[vil_addr_no_code]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_addr_no_code](
	[addr_no] [nchar](7) NULL,
	[addr_name] [nchar](45) NULL
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[vil_adj_traffic]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_adj_traffic](
	[plate_no] [nchar](15) NULL,
	[car_kind_no] [nchar](4) NULL,
	[vil_kind_no] [nchar](2) NULL,
	[vehicle_kind_no] [nchar](2) NULL,
	[reg_seq] [int] NULL,
	[dmv] [nchar](2) NULL,
	[adj_no] [nchar](3) NULL,
	[adj_id] [nchar](10) NULL,
	[owner_no] [nchar](10) NULL,
	[driver_id] [nchar](10) NULL,
	[driver_birthday] [date] NULL,
	[vil_ticket] [nchar](11) NOT NULL,
	[adj_level] [nchar](1) NULL,
	[penalty] [int] NULL,
	[mark] [int] NULL,
	[d_susp] [nchar](2) NULL,
	[v_susp] [nchar](2) NULL,
	[adj_date] [date] NULL,
	[arv30_date] [date] NULL,
	[arv31_date] [date] NULL,
	[arv45_date] [date] NULL,
	[arv46_date] [date] NULL,
	[rcv_state] [nchar](1) NULL,
	[rcv_date] [date] NULL,
	[force_state] [nchar](1) NULL,
	[force_date] [date] NULL,
	[protest_state] [nchar](1) NULL,
	[protest_date] [date] NULL,
	[close_no] [nchar](2) NULL,
	[adj_uid] [nchar](20) NULL,
	[close_uid] [nchar](20) NULL,
	[close_dmv] [nchar](2) NULL,
	[now_dmv] [nchar](2) NULL,
	[up_date] [date] NULL,
	[source] [nchar](1) NULL,
	[pay_way] [nchar](2) NULL,
	[vehicle_state] [nchar](1) NULL,
	[driver_state] [nchar](1) NULL,
	[vehicle_driver_status] [nchar](1) NULL,
	[resp_people_type] [nchar](1) NULL,
	[update_dt] [datetime] NULL,
	[update_uid] [nchar](20) NULL,
	[update_dmv] [nchar](2) NULL,
	[car_plate_no] [nchar](10) NULL
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[vil_adm_handle_code]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_adm_handle_code](
	[adm_handle_no] [nchar](2) NOT NULL,
	[adm_handle_name] [nchar](24) NULL
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[vil_adm_remedy_log]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_adm_remedy_log](
	[remedy_id] [int] NOT NULL,
	[plate_no] [nchar](15) NULL,
	[vehicle_kind_no] [nchar](1) NULL,
	[vil_ticket] [nchar](11) NULL,
	[id_no] [nchar](10) NULL,
	[remedy_state] [nchar](2) NULL,
	[remedy_date] [date] NULL,
	[handle_state] [nchar](2) NULL,
	[handle_date] [date] NULL,
	[remedy_doc] [nchar](50) NULL,
	[dmv] [nchar](2) NULL,
	[update_uid] [nchar](20) NULL,
	[update_dt] [datetime] NULL,
	[update_state] [nchar](15) NULL,
	[car_plate_no] [nchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[remedy_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[vil_adm_state_code]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_adm_state_code](
	[adm_state_no] [nchar](2) NOT NULL,
	[adm_state_name] [nchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[adm_state_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[vil_car_kind_code]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_car_kind_code](
	[kind_no] [nchar](4) NULL,
	[kind_name] [nchar](30) NULL,
	[car_type] [nchar](6) NULL
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[vil_car_susp_code]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_car_susp_code](
	[susp_code_no] [smallint] NOT NULL,
	[txn_name] [nchar](120) NULL,
PRIMARY KEY CLUSTERED 
(
	[susp_code_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[vil_car_susp_his]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_car_susp_his](
	[car_susp_seq] [int] NOT NULL,
	[id_no] [nchar](10) NULL,
	[birthday] [date] NULL,
	[dmv] [nchar](2) NULL,
	[susp_no] [nchar](1) NULL,
	[susp_licence] [nchar](1) NULL,
	[rcv_state] [nchar](1) NULL,
	[susp_begin_date] [date] NULL,
	[susp_end_date] [date] NULL,
	[return_date] [date] NULL,
	[susp_doc] [nchar](27) NULL,
	[vil_ticket] [nchar](11) NULL,
	[dept_no] [nchar](4) NULL,
	[counter_id] [nchar](2) NULL,
	[create_uid] [nchar](20) NULL,
	[create_dmv] [nchar](2) NULL,
	[create_dt] [datetime] NULL,
	[update_uid] [nchar](20) NULL,
	[update_dmv] [nchar](2) NULL,
	[update_dt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[car_susp_seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[vil_clause_rule]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_clause_rule](
	[rule_no_seq] [int] NOT NULL,
	[rule_no] [int] NULL,
	[ill_fact] [nchar](240) NULL,
	[first_penalty] [int] NULL,
	[second_penalty] [int] NULL,
	[third_penalty] [int] NULL,
	[fourth_penalty] [int] NULL,
	[vil_kind_no] [nchar](1) NULL,
	[resp_person_type] [nchar](1) NULL,
	[driver_mark_no] [int] NULL,
	[plate_mark_no] [int] NULL,
	[susp_no] [nchar](1) NULL,
	[forbid_no] [nchar](1) NULL,
	[reserve] [nchar](2) NULL,
	[special_punish_no] [nchar](1) NULL,
	[rule_effective_date] [date] NULL,
	[is_collection] [nchar](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[rule_no_seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[vil_close_code]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_close_code](
	[close_no] [nchar](2) NULL,
	[close_name] [nchar](12) NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[vil_div_detail]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_div_detail](
	[div_id] [int] NOT NULL,
	[plate_no] [nchar](15) NULL,
	[vil_ticket] [nchar](11) NULL,
	[apply_date] [date] NULL,
	[installment] [int] NULL,
	[penalty] [int] NULL,
	[create_uid] [nchar](20) NULL,
	[create_dmv] [nchar](2) NULL,
	[create_dt] [datetime] NULL,
	[update_uid] [nchar](20) NULL,
	[update_dmv] [nchar](2) NULL,
	[update_dt] [datetime] NULL,
	[installment_status] [nchar](1) NULL,
	[system_dt] [datetime] NULL,
	[car_plate_no] [nchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[div_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[vil_dmv_code]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_dmv_code](
	[dmv_no] [nchar](2) NOT NULL,
	[dmv_name] [nchar](36) NULL,
	[dmv_addr] [nchar](60) NULL,
PRIMARY KEY CLUSTERED 
(
	[dmv_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[vil_drv_susp_code]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_drv_susp_code](
	[susp_no] [nchar](2) NULL,
	[susp_name] [nchar](30) NULL,
	[susp_type] [nchar](1) NULL
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[vil_hold_code]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_hold_code](
	[hold_no] [nchar](2) NOT NULL,
	[hold_name] [nchar](12) NULL,
PRIMARY KEY CLUSTERED 
(
	[hold_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[vil_law_close_status_code]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_law_close_status_code](
	[close_status] [nchar](1) NULL,
	[close_name] [nchar](30) NULL
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[vil_law_compete]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_law_compete](
	[id_no] [nchar](10) NOT NULL,
	[birthday] [date] NULL,
	[compete_type] [nchar](1) NULL,
	[compete_office_no] [nchar](3) NULL,
	[compete_law] [nchar](60) NULL,
	[judgment_content] [nchar](120) NULL,
	[judgment_code] [nchar](1) NULL,
	[driver_lic_type] [nchar](1) NULL,
	[dmv] [nchar](4) NULL,
	[counter_id] [nchar](2) NULL,
	[vil_ticket] [nchar](11) NOT NULL,
	[case_closed_status] [nchar](1) NULL,
	[case_closed_detail] [nchar](1) NULL,
	[case_closed_amount] [int] NULL,
	[case_closed_unit] [nchar](9) NULL,
	[legal_wage_hour] [int] NULL,
	[legal_wage_day] [int] NULL,
	[legal_wage_month] [int] NULL,
	[case_closed_payment] [int] NULL,
	[judgment_begin_date] [date] NULL,
	[judgment_end_date] [date] NULL,
	[return_date] [date] NULL,
	[judgment_doc_type] [nchar](24) NULL,
	[judgment_doc_id] [nchar](90) NULL,
	[case_description] [nchar](90) NULL,
	[case_detail_description] [nchar](90) NULL,
	[create_dt] [datetime] NULL,
	[create_uid] [nchar](20) NULL,
	[create_dmv] [nchar](2) NULL,
	[update_uid] [nchar](20) NULL,
	[update_dmv] [nchar](2) NULL,
	[update_dt] [datetime] NULL
) ON [PRIMARY]

GO



/****** Object:  Table [dbo].[vil_lic_type]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_lic_type](
	[lic_type_no] [nchar](2) NULL,
	[lic_name] [nchar](30) NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[vil_migrate]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_migrate](
	[plate_no] [nchar](15) NOT NULL,
	[car_kind_no] [nchar](4) NULL,
	[vehicle_kind_no] [nchar](1) NULL,
	[vil_ticket] [nchar](11) NOT NULL,
	[punish_id] [nchar](10) NULL,
	[rule1_no] [int] NULL,
	[rule2_no] [int] NULL,
	[accuse_no] [nchar](4) NULL,
	[old_dmv] [nchar](2) NULL,
	[close_no] [nchar](2) NULL,
	[hold] [nchar](3) NULL,
	[new_accuse_no] [nchar](4) NULL,
	[new_dmv] [nchar](2) NULL,
	[migrate_reason] [nchar](2) NULL,
	[migrate_doc] [nchar](50) NULL,
	[migrate_date] [date] NULL,
	[update_uid] [nchar](20) NULL,
	[car_plate_no] [nchar](10) NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[vil_motor_susp_his]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_motor_susp_his](
	[motor_susp_seq] [int] NOT NULL,
	[id_no] [nchar](10) NULL,
	[birthday] [date] NULL,
	[dmv] [nchar](2) NULL,
	[susp_no] [nchar](1) NULL,
	[susp_licence] [nchar](1) NULL,
	[rcv_state] [nchar](1) NULL,
	[susp_begin_date] [date] NULL,
	[susp_end_date] [date] NULL,
	[return_date] [date] NULL,
	[susp_doc] [nchar](27) NULL,
	[vil_ticket] [nchar](11) NULL,
	[dept_no] [nchar](4) NULL,
	[counter_id] [nchar](2) NULL,
	[create_uid] [nchar](20) NULL,
	[create_dmv] [nchar](2) NULL,
	[create_dt] [datetime] NULL,
	[update_uid] [nchar](20) NULL,
	[update_dmv] [nchar](2) NULL,
	[update_dt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[motor_susp_seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[vil_pay_month]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_pay_month](
	[pay_month_seq] [int] NOT NULL,
	[plate_no] [nchar](15) NULL,
	[vehicle_kind_no] [nchar](1) NULL,
	[driver_id] [nchar](10) NULL,
	[company_id] [nchar](10) NULL,
	[name] [nchar](120) NULL,
	[apply_date] [date] NULL,
	[end_date] [date] NULL,
	[tel_day] [nchar](26) NULL,
	[tel_night] [nchar](26) NULL,
	[zip] [nchar](5) NULL,
	[addr] [nchar](120) NULL,
	[installment_kind] [nchar](1) NULL,
	[installment_reason] [nchar](1) NULL,
	[installment_doc] [nchar](90) NULL,
	[period] [int] NULL,
	[case_amount] [int] NULL,
	[penalty] [int] NULL,
	[avg_penalty] [int] NULL,
	[last_penalty] [int] NULL,
	[create_uid] [nchar](20) NULL,
	[create_dmv] [nchar](2) NULL,
	[update_uid] [nchar](20) NULL,
	[update_dmv] [nchar](2) NULL,
	[update_date] [date] NULL,
	[installment_status] [nchar](1) NULL,
	[update_dt] [datetime] NULL,
	[car_plate_no] [nchar](10) NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[vil_pay_month_detail]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_pay_month_detail](
	[month_detail_seq] [int] NOT NULL,
	[plate_no] [nchar](15) NULL,
	[vehicle_kind_no] [nchar](2) NULL,
	[driver_id] [nchar](10) NULL,
	[company_id] [nchar](10) NULL,
	[apply_date] [date] NULL,
	[installment_kind] [nchar](1) NULL,
	[vil_ticket] [nchar](11) NULL,
	[update_date] [date] NULL,
	[penalty] [int] NULL,
	[payment] [int] NULL,
	[close_no] [nchar](2) NULL,
	[period] [int] NULL,
	[update_dt] [datetime] NULL,
	[create_uid] [nchar](20) NULL,
	[create_dmv] [nchar](2) NULL,
	[update_uid] [nchar](20) NULL,
	[update_dmv] [nchar](2) NULL,
	[pay_month_seq] [int] NULL,
	[car_plate_no] [nchar](10) NULL
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[vil_pay_way_code]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_pay_way_code](
	[pay_no] [nchar](2) NULL,
	[pay_name] [nchar](12) NULL
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[vil_phone_xact]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_phone_xact](
	[trans_dt] [datetime] NULL,
	[vil_type] [nchar](1) NULL,
	[vil_ticket] [nchar](11) NULL,
	[rule1_no] [int] NULL,
	[rule2_no] [int] NULL,
	[rule3_no] [int] NULL,
	[rule4_no] [int] NULL,
	[xact_dt] [datetime] NULL,
	[bank_check_dt] [date] NULL,
	[xact_treasury_dt] [datetime] NULL,
	[payment] [int] NULL,
	[status] [smallint] NULL,
	[bank_code] [smallint] NULL,
	[source] [smallint] NULL,
	[pay_way] [nchar](1) NULL,
	[plate_no] [nchar](15) NULL,
	[car_kind_no] [nchar](4) NULL,
	[id_no] [nchar](10) NULL,
	[birthday] [date] NULL,
	[adj_no] [nchar](3) NULL,
	[apply_dt] [datetime] NULL,
	[card_no] [nchar](16) NULL,
	[car_plate_no] [nchar](10) NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[vil_plate_susp_his]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_plate_susp_his](
	[plate_susp_seq] [int] NOT NULL,
	[plate_no] [nchar](15) NULL,
	[vehicle_kind_no] [nchar](2) NULL,
	[reg_seq] [int] NULL,
	[first_dmv] [nchar](2) NULL,
	[plate_susp_code] [nchar](5) NULL,
	[receive_state] [nchar](1) NULL,
	[vil_begin_date] [date] NULL,
	[vil_end_date] [date] NULL,
	[return_date] [date] NULL,
	[susp_doc] [nchar](27) NULL,
	[vil_ticket] [nchar](11) NULL,
	[dept_no] [nchar](4) NULL,
	[now_dmv] [nchar](2) NULL,
	[adj_no] [nchar](3) NULL,
	[counter_no] [nchar](2) NULL,
	[create_uid] [nchar](20) NULL,
	[create_dmv] [nchar](2) NULL,
	[create_dt] [datetime] NULL,
	[update_uid] [nchar](20) NULL,
	[update_dmv] [nchar](2) NULL,
	[update_dt] [datetime] NULL,
	[car_plate_no] [nchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[plate_susp_seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[vil_query_log]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_query_log](
	[query_seq] [int] NOT NULL,
	[plate_no] [nchar](15) NULL,
	[id_no] [nchar](10) NULL,
	[vil_ticket] [nchar](11) NULL,
	[vehicle_kind_no] [nchar](2) NULL,
	[query_type] [nchar](1) NULL,
	[query_uid] [nchar](20) NULL,
	[query_dmv] [nchar](2) NULL,
	[apply_dt] [datetime] NULL,
	[program_name] [nchar](36) NULL
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[vil_rcv_state_code]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_rcv_state_code](
	[rcv_sts_no] [nchar](3) NULL,
	[rcv_sts_name] [nchar](21) NULL
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[vil_receipt_payment]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_receipt_payment](
	[receipt_seq] [int] NOT NULL,
	[receipt_id] [nchar](11) NULL,
	[receipt_no] [int] NULL,
	[receipt_type] [nchar](1) NULL,
	[vil_type] [nchar](1) NULL,
	[punish_class] [nchar](1) NULL,
	[plate_id_no] [nchar](15) NULL,
	[vil1_ticket] [nchar](11) NULL,
	[refund_name] [nchar](120) NULL,
	[vil3_ticket] [nchar](11) NULL,
	[vil4_ticket] [nchar](11) NULL,
	[vil5_ticket] [nchar](11) NULL,
	[total_payment] [int] NULL,
	[cash_date] [datetime] NULL,
	[receipt_state] [nchar](1) NULL,
	[close_no] [nchar](2) NULL,
	[create_dt] [datetime] NULL,
	[create_uid] [nchar](20) NULL,
	[create_dmv] [nchar](2) NULL,
	[cash_uid] [nchar](20) NULL,
	[cash_dmv] [nchar](2) NULL,
	[channel_type] [nchar](2) NULL,
	[refund_type] [nchar](2) NULL,
	[update_dt] [datetime] NULL,
	[update_uid] [nchar](20) NULL,
	[update_dmv] [nchar](6) NULL,
	[car_plate_no] [nchar](10) NULL,
	[desk_id] [nchar](3) NULL,
	[div_pay] [nchar](40) NULL,
PRIMARY KEY CLUSTERED 
(
	[receipt_seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[vil_traffic_rule]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_traffic_rule](
	[vil_ticket] [nchar](11) NULL,
	[accuse_no] [nchar](4) NULL,
	[plate_no] [nchar](15) NULL,
	[vil_kind_no] [nchar](2) NULL,
	[car_kind_no] [nchar](4) NULL,
	[vehicle_kind_no] [nchar](2) NULL,
	[driver_id] [nchar](10) NULL,
	[driver_birthday] [date] NULL,
	[company_id] [nchar](10) NULL,
	[accuse_type] [nchar](1) NULL,
	[resp_people_type] [nchar](1) NULL,
	[rule1_no] [int] NULL,
	[rule2_no] [int] NULL,
	[rule3_no] [int] NULL,
	[rule4_no] [int] NULL,
	[vil_address_no] [nchar](7) NULL,
	[vil_dt] [datetime] NULL,
	[arrive_date] [date] NULL,
	[hold_no] [nchar](6) NULL,
	[back_date] [date] NULL,
	[dmv] [nchar](2) NULL,
	[adj_no] [nchar](3) NULL,
	[counter_no] [nchar](2) NULL,
	[accuse_state] [nchar](1) NULL,
	[receive_state] [nchar](1) NULL,
	[receive_date] [date] NULL,
	[payment] [int] NULL,
	[penalty] [int] NULL,
	[penalty_level] [nchar](1) NULL,
	[pay_way_no] [nchar](2) NULL,
	[plate_susp] [int] NULL,
	[driver_susp] [int] NULL,
	[forbid_test] [int] NULL,
	[traffic_safety_lecture_state] [nchar](1) NULL,
	[vil_location] [nchar](52) NULL,
	[is_forced] [nchar](1) NULL,
	[in_date] [date] NOT NULL,
	[create_uid] [nchar](20) NULL,
	[create_dmv] [nchar](2) NULL,
	[is_adjudged] [nchar](1) NULL,
	[close_no] [nchar](2) NULL,
	[is_protest] [nchar](1) NULL,
	[up_date] [date] NULL,
	[update_dmv] [nchar](10) NULL,
	[update_uid] [nchar](20) NULL,
	[adj_date] [date] NULL,
	[deputy] [nchar](6) NULL,
	[adjudicator] [nchar](20) NULL,
	[previous_receive_state] [nchar](1) NULL,
	[previous_receive_date] [date] NULL,
	[installment_type] [nchar](1) NULL,
	[law_relation_type] [nchar](1) NULL,
	[update_dt] [datetime] NULL,
	[system_access] [nchar](20) NULL,
	[cancel_state] [nchar](2) NULL,
	[car_plate_no] [nchar](10) NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[vil_vehicle_kind_code]    Script Date: 2016/3/22 上午 11:06:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vil_vehicle_kind_code](
	[vehicle_kind_no] [nchar](2) NOT NULL,
	[kind_name] [nchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[vehicle_kind_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO