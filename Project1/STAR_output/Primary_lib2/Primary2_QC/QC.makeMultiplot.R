# This is an automatically-generated R script designed to make a simple multiplot and/or pdf report for a sample.
message("STARTING...");
library(QoRTs);
unique.ID <- c("Untitled");
qc.data.dir <- c("/projects/micb405/project1/Team10/STAR_output/Primary_lib2//Primary2_QC//");
qc.data.prefix <- c("");
decoder.raw <- data.frame(unique.ID = as.character(unique.ID), qc.data.dir = as.character(qc.data.dir), qc.data.prefix=as.character(qc.data.prefix),stringsAsFactors=FALSE);
decoder <- completeAndCheckDecoder(decoder = decoder.raw)
message(decoder);
message(lapply(names(decoder), function(n){ class(decoder[[n]]) }));
res <- read.qc.results.data("", decoder = decoder, calc.DESeq2 = FALSE, calc.edgeR = FALSE);
#makeMultiPlot.basic(res, outfile = "/projects/micb405/project1/Team10/STAR_output/Primary_lib2//Primary2_QC//QC.multiPlot.png", plotter.params = list(std.color = "blue", std.lines.lwd = 4), plot.device.name = "png");
makeMultiPlot.basic(res, outfile = "/projects/micb405/project1/Team10/STAR_output/Primary_lib2//Primary2_QC//QC.multiPlot.pdf", plotter.params = list(std.color = "blue", std.lines.lwd = 4), plot.device.name = "pdf");
#makeMultiPlot.basic(res, outfile.dir = paste0("/projects/micb405/project1/Team10/STAR_output/Primary_lib2//Primary2_QC/","QCplots/"), plotter.params = list(std.color = "blue", std.lines.lwd = 4), plot.device.name = "png", separatePlots = TRUE);
message("DONE...");



