\name{dataI}
\alias{dataI}
\docType{data}
\title{ Reverse phase protein array rawdata, samples serially diluted}
\description{
   The data Set is a list of four elements. Expression and background are matrices
   containing signal intensities, the data frames arraydescription and sampledescription
   comprising feature and phenodata.
   
}
\usage{data(dataI)}
\format{
  list
}
\details{
The data set is a list of four elements with data of a original reverse phase
array experiment. The elements expression and background are 2304 times 26 matrices
containing integers describing the signal intensities and local background for every spot of the
experiment as generated with image analysis software.
Arraydescription is a data frame, describing the incubation of every array
refering the column of the expression and background matrix. Required rows are target
and AB_ID with characters and array.id (four integers linked with "-").
Sampledescription is a data frame according to the rows of expression and
background matrix and annotates the samples. Sampledescription requires the
columns "ID", "sample_type", "sample", "concentration", and "dilution"
  as minimal information and "sample.n" to separate different sample groups.
}
\source{
 The data set contains original reverse phase protein array signals
  with randomized pheno and feature data.
}

\examples{
\donttest{
data(dataI)
str(dataI)
}
}
\keyword{datasets}
