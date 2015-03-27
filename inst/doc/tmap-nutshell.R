## ----setup, include=FALSE------------------------------------------------
library(knitr)
library(tmap)

## ------------------------------------------------------------------------
data(Europe)

## ----, fig.height=5------------------------------------------------------
qtm(Europe)

## ----, fig.height=5------------------------------------------------------
qtm(Europe, fill="gdp_cap_est", text="iso_a3", text.cex="AREA", root=5, title="GDP per capita", 
	fill.textNA="Non-European countries", theme="Europe")

## ----, eval=FALSE--------------------------------------------------------
#  tm_shape(Europe) +
#  	tm_fill("gdp_cap_est", textNA="Non-European countries") +
#  	tm_borders() +
#  	tm_text("iso_a3", cex="AREA", root=5) +
#  tm_layout_Europe("GDP per capita")

## ----, fig.width=10------------------------------------------------------
data(rivers)
data(cities)

tm_shape(Europe) +
	tm_fill("pop_est_dens", style="kmeans", textNA="Non-European countries") +
	tm_borders() +
tm_shape(rivers) +
	tm_lines("dodgerblue3") +
tm_shape(cities) +
	tm_text("name", cex="pop_min", scale=1, ymod=-.02, root=4, cex.lowerbound = .60, 
			bg.color="yellow", bg.alpha = .5) + 
	tm_bubbles("pop_max", "red", border.col = "black", border.lwd=1, size.lim = c(0, 11e6), sizes.legend = seq(2e6,10e6, by=2e6)) +
tm_shape(Europe) +
	tm_text("name", cex="area", scale=1.5, root=8, cex.lowerbound = .40, 
			fontface="bold", case=NA, fontcolor = "gray35") + 
tm_layout_Europe("Map of Europe", legend.titles = c(fill="Country population density (per km2)", 
													bubble.size="City Population"))

## ----, fig.width=10, fig.height=3----------------------------------------
tm_shape(Europe) +
	tm_fill(c("pop_est_dens", "gdp_cap_est"), style="kmeans") +
tm_layout_Europe(title = c("Population density", "GDP per capita"))

## ----, fig.width=10------------------------------------------------------
tm_shape(Europe) +
	tm_fill("gdp_cap_est", style="kmeans") +
tm_facets("part") +
tm_layout_Europe(legend.titles = c(fill="GDP per capita"))

## ----, fig.width=10------------------------------------------------------
tm_shape(Europe[Europe$continent=="Europe",]) +
	tm_fill("part", thres.poly = 0) +
tm_facets("name", free.coords=TRUE, drop.shapes=TRUE) +
	tm_layout(legend.show = FALSE, title.position = c("center", "center"), title.cex = 2)

## ----, eval=FALSE--------------------------------------------------------
#  pdf("my_map.pdf", width=10, height=6)
#  tm_shape(Europe) +
#  	tm_fill("gdp_cap_est", textNA="Non-European countries") +
#  	tm_borders() +
#  	tm_text("iso_a3", cex="AREA", root=5) +
#  tm_layout("GDP per capita")
#  dev.off()

## ----, eval=FALSE--------------------------------------------------------
#  animation_tmap({
#  	tm_shape(Europe) +
#  	    tm_fill("yellow") +
#  	    tm_borders() +
#  	    tm_facets(by = "name", nrow=1,ncol=1)
#  }, width=1200, height=800, filename="my_animation.gif")

## ----, fig.height=4------------------------------------------------------
tm_shape(Europe[Europe$name=="Austria", ]) +
	tm_fill() +
	tm_borders()

## ----, fig.height=3------------------------------------------------------
data(World)

rivers$constant <- factor("Rivers")
tm_shape(World) +
	tm_fill() +
tm_shape(rivers) +
	tm_lines(col="constant", palette="dodgerblue3") +
	tm_layout_World("World map")

