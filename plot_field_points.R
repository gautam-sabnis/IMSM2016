#Thanks to Ben Shaby @ UC - Berkeley!

plot_field_points <- function(locs, data, zlim, xlim, ylim,empty_locs=diag(2),
                              projection, add=FALSE, legend=TRUE,gray=FALSE,
                              legend.offset=4, pch=20, cex=4, n.color=64, 
                              map.borders=NULL, parameters=NULL, ...)
{
  require(fields)
  require(maps)
  
  miss<-is.na(data)
  data<-data[!miss]
  locs<-locs[!miss,]
  
  
  if (missing(zlim))
    zlim <- range(data)
  
  if (missing(xlim))
    xlim <- range(locs[ ,1])
  
  if (missing(ylim))
    ylim <- range(locs[ ,2])
  
  if (!missing(projection)) {
    require(mapproj)
    proj <- mapproject(locs[ ,1], locs[ ,2], projection=projection)
    locs <- cbind(proj$x, proj$y)
  }
  
  
  plot.range <- zlim
  # Which data points are outside the allowed range?
  outside.range <- ((data < plot.range[1]) | (data > plot.range[2]))
  # A scaled version of the data that's between 1 and n.color
  pos.data <- data - plot.range[1]
  pos.data <- pos.data / (plot.range[2]-plot.range[1]) * (n.color-1) + 1
  # Put in a dummy value if the data is not in range
  pos.data[outside.range] <- 1
  # Assign a color to each data point
  cols <- tim.colors(n.color)[pos.data]
  if(gray){
    grays<-gray(seq(0.99,0.01,length=n.color)^0.5)
    cols <- grays[pos.data]
  }
  
  # Make the data points that are outside the range white
  cols[outside.range] <- "#FFFFFF"
  
  if (!add) {
    if (legend) {
      old.par <- par(no.readonly=TRUE)
      par(oma=c(0,0,0,legend.offset))
      if (missing(projection)) {
        plot(locs[ ,1], locs[ ,2], xlim=xlim, ylim=ylim, type="n", ...)
      } else {
        map(xlim=xlim, ylim=ylim, projection=projection, type="n", ...)
      }
      points(locs[ ,1], locs[ ,2], col=cols, pch=pch, cex=cex, ...)
      points(empty_locs[ ,1], empty_locs[ ,2], col=0,pch=1,cex=1, ...)
      if (!is.null(map.borders)) {
        if(!missing(projection)) {
          map(map.borders, add=TRUE, 
              xlim=xlim, ylim=ylim, projection=projection, ...)
        } else {
          map(map.borders, add=TRUE, 
              xlim=xlim, ylim=ylim, ...)
        }
      }
      par(old.par)
      if(!gray){
        quilt.plot(x=locs[ ,1], y=locs[ ,2], z=data, legend.only=TRUE, zlim=zlim)
      }
      if(gray){
        quilt.plot(x=locs[ ,1], y=locs[ ,2], z=data, col=grays,legend.only=TRUE, zlim=zlim)
      }
    } else {
      plot(locs[ ,1], locs[ ,2], col=cols, pch=pch, cex=pch, ...)
    }
  } else {
    points(locs[ ,1], locs[ ,2], col=cols, cex=cex, pch=pch, ...)  
  }
}