## ----setup, include=FALSE------------------------------------------------
library(knitr)
library(tmap)

## ------------------------------------------------------------------------
data(Europe)

## ---- fig.height=5-------------------------------------------------------
qtm(Europe)

## ---- fig.height=5-------------------------------------------------------
qtm(Europe, fill="gdp_cap_est", text="iso_a3", text.size="AREA", root=5, fill.title="GDP per capita", 
	fill.textNA="Non-European countries", theme="Europe")

## ---- eval=FALSE---------------------------------------------------------
#  tm_shape(Europe) +
#  	tm_fill("gdp_cap_est", textNA="Non-European countries", title="GDP per capita") +
#  	tm_borders() +
#  	tm_text("iso_a3", size="AREA", root=5) +
#  tm_layout_Europe()

## ---- fig.width=10-------------------------------------------------------
data(rivers)
data(metro)

tm_shape(Europe) +
    tm_fill("pop_est_dens", style="kmeans", textNA="Non-European countries", 
    title="Country population density (per km2)") +
    tm_borders() +
tm_shape(rivers) +
    tm_lines("dodgerblue3") +
tm_shape(metro) +
    tm_text("name", size="pop2010", scale=1, ymod=-.02, root=4, size.lowerbound = .60, 
        bg.color="yellow", bg.alpha = .5) + 
	tm_bubbles("pop2010", "red", border.col = "black", border.lwd=1, size.lim = c(0, 11e6), 
        sizes.legend = seq(2e6,10e6, by=2e6), title.size="Metropolitan Population") +
tm_shape(Europe) +
	tm_text("iso_a3", size="area", scale=1.5, root=8, size.lowerbound = .40, 
        fontface="bold", case=NA, fontcolor = "gray35") + 
tm_layout_Europe("Map of Europe")

## ---- fig.width=10, fig.height=3-----------------------------------------
tm_shape(Europe) +
	tm_fill(c("pop_est_dens", "gdp_cap_est"), style="kmeans", 
        title=c("Population density", "GDP per capita")) +
tm_layout_Europe()

## ---- fig.width=10-------------------------------------------------------
tm_shape(Europe) +
    tm_fill("gdp_cap_est", style="kmeans", title="GDP per capita") +
    tm_facets("part") +
tm_layout_Europe()

## ---- fig.width=10-------------------------------------------------------
tm_shape(Europe[Europe$continent=="Europe",]) +
    tm_fill("part", thres.poly = 0) +
    tm_facets("name", free.coords=TRUE, drop.shapes=TRUE) +
tm_layout(legend.show = FALSE, title.position = c("center", "center"), title.size = 2)

## ---- fig.width=10-------------------------------------------------------
data(land)
data(World)
pal8 <- c("#33A02C", "#B2DF8A", "#FDBF6F", "#1F78B4", "#999999", "#E31A1C", "#E6E6E6", "#A6CEE3")
tm_shape(land, ylim = c(-88,88), relative=FALSE) +
    tm_raster("cover_cls", palette = pal8, title="Global Land Cover", legend.hist=TRUE, legend.hist.z=0) +
tm_shape(World) +
    tm_borders() +
tm_layout_World(inner.margins=0, 
    legend.text.size=1,
    legend.title.size=1.2,
    legend.position = c("left","bottom"), 
    legend.bg.color = "white", legend.bg.alpha=.2, 
    legend.frame="gray50", 
    legend.width=.2, legend.height=.6, 
    legend.hist.height=.2, 
    legend.hist.bg.color="gray60", legend.hist.bg.alpha=.5)

## ---- fig.width=10-------------------------------------------------------
(tm <- tm_shape(World) +
    tm_fill() +
    tm_borders() +
tm_layout(bg.color = "lightblue", outer.margins=c(.05,0,.05,0), 
    inner.margins=c(0,0,.02,0), asp=0))

## ---- fig.width=10-------------------------------------------------------
tm + tm_layout(design.mode=TRUE)

## ---- eval=FALSE---------------------------------------------------------
#  pdf("my_map.pdf", width=10, height=6)
#  tm_shape(Europe) +
#  	tm_fill("gdp_cap_est", textNA="Non-European countries", title="GDP per capita") +
#  	tm_borders() +
#  	tm_text("iso_a3", size="AREA", root=5)
#  dev.off()

## ---- eval=FALSE---------------------------------------------------------
#  animation_tmap({
#  	tm_shape(Europe) +
#  	    tm_fill("yellow") +
#  	    tm_borders() +
#  	    tm_facets(by = "name", nrow=1,ncol=1)
#  }, width=1200, height=800, filename="my_animation.gif")

## ---- fig.height=4-------------------------------------------------------
tm_shape(Europe[Europe$name=="Austria", ]) +
	tm_polygons()

## ---- fig.height=3-------------------------------------------------------
data(World)

rivers$constant <- factor("Rivers")
tm_shape(World) +
	tm_fill() +
tm_shape(rivers) +
	tm_lines(col="constant", palette="dodgerblue3", title.col="World map") +
tm_layout_World()

