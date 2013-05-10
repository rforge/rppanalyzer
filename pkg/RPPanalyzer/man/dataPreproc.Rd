\name{dataPreproc}
\alias{dataPreproc}
\title{
  Data preprocessing
}
\description{
Function for import, normalization and quality checks of data prior to the actual analysis.
The preprocessing steps include subtraction of dilution series intercepts and FCF normalization.
Additionally plots for quality checks are generated including dilutions and BLANK measurements.

}
\usage{
  dataPreproc(dataDir=getwd(), blocks=12, spot="aushon", exportNo=4)
}

\arguments{
  \item{dataDir}{directory of gpr files, slidedescription.txt and sampledescription.txt, default is the current working directory}
  \item{blocks}{see \code{blocksperarray} in \code{\link{read.Data}}, default is 12}
  \item{spot}{see \code{spotter} in \code{\link{read.Data}}, default is "aushon"}
  \item{exportNo}{see \code{exportNo} in \code{\link{correctDilinterc}}, integer of 1-4 defining the linear fit to be used (1: constant, 2: antibody, 3: antibody + slide, 4: antibody + slide + sample), default is 4}
}
\value{
A list of 4 elements is returned.
  \item{rawdat}{list of 4 raw data elements (\code{expression} and \code{background} matrices, \code{arraydescription} and \code{sampledescription} data frames) according to \code{\link{read.Data}}}
  \item{cordat}{list of 4 elements like \code{rawdat} with \code{expression} data corrected to dilution intercepts, in case of resulting negative values the absoulte minimum + 1 is added, \code{expression} data is without NAs and is reduced to the \code{measurement} sample type, \code{background} is not corrected to intercepts, as it is not used here}
  \item{normdat}{list of 4 elements like \code{cordat} with \code{expression} as dilution intercept and FCF normalized foreground data, the neglected background data are renamed here to \code{dummy} and should not be used}
  \item{DIR}{directory for storing the generated outputs}

All output files are stored in an analysis folder labeled by the date of analysis.
The txt files \code{Dataexpression} and \code{Databackground} result from \code{\link{write.Data}} and store the raw data.
The pdf files \code{getIntercepts_Output} and \code{anovaIntercepts_Output} result from \code{\link{correctDilinterc}}.  
\code{getIntercepts_Output} shows the derived intercepts and smoothing splines of dilution series in dependence of the \code{dilSeriesID} column in sampledescription.txt and the slide/pad/incubationRun/spottingRun columns of the \code{arraydescription} matrix.
\code{anovaIntercepts_Output.pdf} results from the ANOVA in \code{\link{correctDilinterc}}, comparing different linear models of the dilution series intercepts. The barplot displays the residual sum of squares (RSS) of the individual model fits. It helps to choose the appropriate \code{exportNo} parameter. As RSS decreases, the model fits better.
Finally, three pdf files for quality checking are returned. 
\code{QC_dilutioncurve_raw.pdf} plots target and blank (2nd antibody only) signals from serially diluted control samples of the raw RPPA data set, see \code{\link{plotQC}}.
\code{QC_targetVSblank_normed.pdf} plots blank signals vs. target specific signals of dilution intercept corrected and FCF normalized RPPA data, see \code{\link{plotMeasurementsQC}}.
\code{QC_qqPlot_normed.pdf} containes qq-plots of dilution intercept corrected and FCF normalized RPPA data, see \code{\link{plotqq}}.
}
\author{
 Silvia von der Heyde
}
\examples{\dontrun{
library(RPPanalyzer)
  
# get output list 
res<-dataPreproc(dataDir=getwd(), blocks=12, spot="aushon", exportNo=4)

# get individual elements
# raw data
rawdat<-res$rawdat
# dilution intercept corrected data
cordat<-res$cordat
# dilution intercept corrected and FCF normalized data
normdat<-res$normdat
# output directory
DIR<-res$DIR
}
}