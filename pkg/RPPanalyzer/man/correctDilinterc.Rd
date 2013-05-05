\name{correctDilinterc}
\alias{correctDilinterc}
\title{
Dilution series intersect correction
}
\description{
Consists of 3 functions: getIntercepts(), analyzeIntercepts() and getSignals().
The first one derives intercepts of dilution series in dependence of dilSeriesID (column in sampledescription.txt) and slide/pad/incubationRun/spottingRun number (colnames of arraydescription). A smoothing spline is used to extrapolate to 0. Nonparametric bootstrap is used to estimate uncertainty of the intercept estimate.
The second function is used in the last one and does Analysis of Variances for nested models.
The last one updates the original timeseries signal to (foreground expression - intercept).
}
\usage{
correctDilinterc(dilseries, arraydesc, timeseries, exportNo)
}
\arguments{
  \item{dilseries}{foreground signal matrix as result of write.Data() and import of resulting txt file, but just sample_type "control", i.e. dilution series}
  \item{arraydesc}{"arraydescription" matrix of the RPPA data set list}
  \item{timeseries}{foreground signal matrix as result of write.Data() and import of resulting txt file, but just sample_type "measurement"}
  \item{eportNo}{integer of 1-4 (see R script) which of the linear fits should be exported to the attribute of the result, variable for analyzeIntercepts()}
}
\value{
matrix with adapted signal intensities via subtraction of dilution intercept at concentration 0
}
\author{
Daniel Kaschek, Silvia von der Heyde
}
\examples{
	library(RPPanalyzer)
	data(dataII)
  write.Data(dataII)
  times<-read.delim("Datasample.medians.txt", skip=8, stringsAsFactors=FALSE, row.names=NULL, header=TRUE, ,check.names=FALSE)
  # adapt data set for this example
  times<-times[which(times$sample!="cellline1"),]
  # workaround: add column 'dilSeriesID' which should actually be already defined in sampledescription.txt, but not for this data set 
  times[,"inhibition"]<-times$sample
  colnames(times)[which(colnames(times)=="inhibition")]<-"dilSeriesID"
  # do intercept correction
  correctedData<-correctDilinterc(dilseries=times[which(times$"sample_type"=="control" & !is.na(times$dilSeriesID)),], arraydesc=dataII[[3]],
                           timeseries=times[which(times$sample_type=="measurement"),],exportNo=4)
}
