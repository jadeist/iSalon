select
		grupos.nombre as 'grupo',
		salones.nombre as 'salon',
		horarios.nombre as 'clase',
		horarios.horaInicio, horarios.horaFinal, horarios.dia, horarios.color
	from horarios
	
	inner join cathorariogrupo
		on cathorariogrupo.idHor = horarios.id

	inner join cathorariosalon
		on cathorariosalon.idHor = horarios.id
		
	inner join salones
		on salones.id = cathorariosalon.idSal

	inner join grupos
		ON grupos.id = cathorariogrupo.idGrp
		
	inner join catgrupousuario
		on catgrupousuario.idGrp

	where dia = 2
		
	order by horarios.horaInicio asc
;