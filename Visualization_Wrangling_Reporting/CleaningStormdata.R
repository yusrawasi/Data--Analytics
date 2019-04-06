load("E:/data analytics/Data_Analytics_Certification/df_stormData_raw.RData")

#copying df_storm_data to cleaning data 
cl_df_stormData_raw <- df_stormData_raw


# view all types of event types entered
View(sort(unique(cl_df_stormData_raw$EVTYPE)))

# change vector class
cl_df_stormData_raw$EVTYPE <- as.character(cl_df_stormData_raw$EVTYPE)


# astronomical low tide is not an overlapping category so no cleaning
 #unique(grep('tide', clean_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE))
#-----------------------------------------------------------------------------------------

# search for avalanche keyword with fuzzy matching
unique(agrep('avalanche', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE))



# assign to indices 
indices <- agrep('avalanche', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE)

                  

# reformat all indices to AVALANCHE
cl_df_stormData_raw$EVTYPE[indices] <- 'AVALANCHE'
#---------------------------------------------------------------------------------------------------
# search for avalanche keyword with fuzzy matching
unique(agrep('blizzard', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE))

# assign to indices 
indices <- agrep('blizzard', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE)


# reformat all indices to blizzard because blizzard is kind of a superset category
cl_df_stormData_raw$EVTYPE[indices] <- 'BLIZZARD'
#----------------------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------------------------------
 # debris flow inlcudes mudslides and other material flows
unique(agrep('(mudslides) | (landslides) | (rockslide)', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE ))

#indices <- agrep('slide', clean_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE )

indices <- agrep('(mudslides) | (landslides) | (rockslide)', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE )

cl_df_stormData_raw$EVTYPE[indices] <- 'DEBRIS FLOW'

unique(agrep('landslump', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, value = TRUE,  fixed = FALSE ))
cl_df_stormData_raw$EVTYPE[agrep('landslump', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE,   fixed = FALSE )] <- 'DEBRIS FLOW'

#unique(agrep('debris flow', clean_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE ))

#--------------------------------------------------------------------------------------------------------------------------------------

# 
unique(agrep('dense fog', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE ))

indices <- agrep('dense fog', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE )

cl_df_stormData_raw$EVTYPE[indices] <- 'DENSE FOG'

#----------------------------------------------------------------------------------------------------------------------------------------------


# 
unique(agrep('dense smoke', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE ))

indices <- agrep('dense smoke', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE )

cl_df_stormData_raw$EVTYPE[indices] <- 'DENSE SMOKE'

#----------------------------------------------------------------------------------------------------------------------------------------------
unique(agrep('drought', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE ))

indices <- agrep('drought', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE )

cl_df_stormData_raw$EVTYPE[indices] <- 'DROUGHT'

#----------------------------------------------------------------------------------------------------------------------------------------------
#unique(agrep('devil', clean_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE))
unique(agrep('dust storm', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE))


#using grep because agrep dust is giving irrelevant stuff

#unique(grep('dust', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE))

#setdiff(unique(grep('dust', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE)),
        #unique(agrep('devil | (saharan) | (blowing)', cleaning_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE)))
#-------
#separating dust storms
indices <- agrep('dust storm', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE)

cl_df_stormData_raw$EVTYPE[indices] <- 'DUST STORM'

#------------------------------------------------------------------------------------------------------------------------------

#now remaing dust as dust devils , using grep because agrep dust is giving irrelevant stuff
unique(grep('dust', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE))

indices <- agrep('dust', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE)

cl_df_stormData_raw$EVTYPE[indices] <- 'DUST DEVIL'

#----------------------------------------------------------------------------------------------------------------------------------------------

unique(agrep('freezing fog', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE ))

indices <- agrep('freezing fog', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE )

cl_df_stormData_raw$EVTYPE[indices] <- 'FREEZING FOG'

#------------------------------------------------------------------------------------------------------------------------------------------------

unique(grep('heat', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE ))

unique(grep('hot', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE ))

unique(grep('^heat', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE ))

# separating normal heat
setdiff(unique(grep('heat', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE )),
               unique(grep('(extreme)|(excessive)|(record)|(burst)', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE )))

indices <- setdiff(grep('heat', cl_df_stormData_raw$EVTYPE,  ignore.case = TRUE, fixed = FALSE ),
                   grep('(extreme)|(excessive)|(record)|(burst)', cl_df_stormData_raw$EVTYPE,  ignore.case = TRUE, fixed = FALSE ))

cl_df_stormData_raw$EVTYPE[indices] <- 'HEAT'
#also including hot
indices <- grep('hot', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE )
cl_df_stormData_raw$EVTYPE[indices] <- 'HEAT'

#--------------------- now excessive heat

setdiff(unique(grep('heat', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE )),
        unique(grep('^heat', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE )))

indices <- setdiff(grep('heat', cl_df_stormData_raw$EVTYPE,  ignore.case = TRUE, fixed = FALSE ),
                   grep('^heat', cl_df_stormData_raw$EVTYPE,  ignore.case = TRUE, fixed = FALSE ))

cl_df_stormData_raw$EVTYPE[indices] <- 'EXCESSIVE HEAT'

#also include heatburst
unique(agrep('heatburst', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE ))

indices <- agrep('heatburst', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE )

cl_df_stormData_raw$EVTYPE[indices] <- 'EXCESSIVE HEAT'


#------------------------------------------------------------------------------------------------------------------------------------------------
unique(grep('(frost)', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE ))
unique(grep('(freez)', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE ))

setdiff(unique(grep('freez', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE )),
        unique(grep('heavy snow|sleet|fog', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE )))

indices <- agrep('frost', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE )

cl_df_stormData_raw$EVTYPE[indices] <- 'FROST/FREEZE'

indices <- setdiff(grep('freez', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE ),
        grep('heavy snow|sleet|fog', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE ))



cl_df_stormData_raw$EVTYPE[indices] <- 'FROST/FREEZE'

#------------------------------------------------------------------------------------------------------------------------------------------------------
unique(agrep('funnel' , cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE ))

indices <- agrep('funnel', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE )

cl_df_stormData_raw$EVTYPE[indices] <- 'FUNNEL CLOUD'


# now also including clouds
unique(agrep('cloud' , cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE ))

indices <- agrep('cloud', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE )

cl_df_stormData_raw$EVTYPE[indices] <- 'FUNNEL CLOUD'
#---------------------------------------------------------------------------------------------------------------------------------------

unique(agrep('hail' , cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE ))
#unique(agrep('marine' , cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE ))

#excluding marine hails


setdiff(unique(agrep('hail', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE)),
        unique(agrep('marine', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE)))

# assign to indices 
indices <- setdiff(agrep('hail', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE),
                   agrep('marine', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE))

cl_df_stormData_raw$EVTYPE[indices] <- 'HAIL'

#---------------------------------------------------------------------------------------------------------------
 

unique(agrep('cloud', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE ))
unique(agrep('cold air', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE ))
indices <- agrep('cloud', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE )

cl_df_stormData_raw$EVTYPE[indices] <- 'FUNNEL CLOUD'

#---------------------------------------------------------------------------------------------------


#floods

#-----------------------------------------------------------------------------------------

unique(agrep('(heavy rain)', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE ))
unique(agrep('urban', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE ))

setdiff(unique(agrep('(heavy rain)', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE )),
        unique(grep('(flash)|(flood)|(surf)', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE )))

indices <- setdiff(agrep('(heavy rain)', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE ),
        grep('(flash)|(flood)|(surf)', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE ))



cl_df_stormData_raw$EVTYPE[indices] <- 'HEAVY RAIN'


# now include urban
indices <- agrep('urban', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE )

cl_df_stormData_raw$EVTYPE[indices] <- 'HEAVY RAIN'



#------------------------------------------------------------------------------------------------------

unique(agrep('heavy snow', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE ))

setdiff(unique(agrep('(heavy snow)', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE )),
        unique(agrep('(storm)', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE )))

#exclude winter storm/ ice storm, but include sleet ice and squals
indices <- setdiff(unique(agrep('heavy snow', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE )),
                   unique(agrep('(storm)', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE )))

cl_df_stormData_raw$EVTYPE[indices] <- 'HEAVY SNOW'


unique(agrep('snow', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE ))

unique(agrep('heavy wet snow', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE ))
unique(agrep('record winter snow', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE ))
unique(agrep('excessive snow', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE ))

# now include record snow
indices <- agrep('record winter snow', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE )

cl_df_stormData_raw$EVTYPE[agrep('record winter snow', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE )] <- 'HEAVY SNOW'

cl_df_stormData_raw$EVTYPE[agrep('record snow', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE,fixed = FALSE )] <- 'HEAVY SNOW'
# now include heavy wet snow
indices <- agrep('heavy wet snow', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE )

cl_df_stormData_raw$EVTYPE[indices] <- 'HEAVY SNOW'

# now include excessive snow
indices <- agrep('excessive snow', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE )

cl_df_stormData_raw$EVTYPE[indices] <- 'HEAVY SNOW'
#----------------------------------------------------------------------------------------------------------------------------
# heavy surf
unique(agrep('surf', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE ))
unique(agrep('swell', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE ))

setdiff(unique(agrep('surf', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE )),
        unique(agrep('(surge)', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE )))
 
indices <- setdiff(agrep('surf', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE ),
        agrep('(surge)', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE ))

cl_df_stormData_raw$EVTYPE[indices] <- 'HIGH SURF'  
cl_df_stormData_raw$EVTYPE[agrep('swell', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE )] <- 'HIGH SURF'

#-----------------------------------------------------------------------------------------------------------------

# high wind
unique(agrep('wind', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE ))
#unique(agrep('lakes', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE ))
#unique(agrep('sustained', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE ))
#unique(agrep('gust', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE ))
#unique(agrep('longer', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE ))



unique(agrep('high wind', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE))

#unique(agrep('snow/ high wind', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE , fixed = FALSE))
#unique(agrep('record cold and high wind', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE , fixed = FALSE))

#exclude flood, hurricane, marine, storm , let snow or cold be there


#--------------- exclude flood for now
unique(agrep('high winds/flooding', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE , fixed = FALSE))
indices <- agrep('high winds/flooding', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE , fixed = FALSE)
cl_df_stormData_raw$EVTYPE[indices] <- 'FLOOD'  
#---------------
unique(agrep('high winds/coastal flood', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE , fixed = FALSE))
indices <- agrep('high winds/coastal flood', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE , fixed = FALSE)
cl_df_stormData_raw$EVTYPE[indices] <- 'COASTAL FLOOD'  
#------------------------------------------------------ ----------------
#exclude hurricane, marine, storm
setdiff(unique(agrep('high wind', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE )),
        unique(agrep('(storm)|(marine)|(hurricane)', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE )))

indices <- setdiff(agrep('high wind', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE ),
                   agrep('(storm)|(marine)|(hurricane)', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE ))

cl_df_stormData_raw$EVTYPE[indices] <- 'HIGH WIND'  

#---------------------------
#include snow and cold
unique(grep('(snow/high winds)|(high winds/snow)|(record cold and high wind)', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE , fixed = FALSE))

indices <- grep('(snow/high winds)|(high winds/snow)|(record cold and high wind)', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE , fixed = FALSE)

cl_df_stormData_raw$EVTYPE[indices] <- 'HIGH WIND' 

#------------------------------------------------------------------------------------------------------------------------------
#flood 
unique(agrep('flood', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE ))
#nique(agrep('erosion', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE ))
#unique(agrep('beach', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE ))

#----------------------------------------------------------

#coastal flooding, exclude surge, storm, include erosion, tidal flood,beach, cstl
unique(agrep('coastal', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE ))
#unique(agrep('tidal flood', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE ))
#unique(agrep('cstl', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE ))


setdiff(unique(agrep('(coastal)', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE )),
        unique(agrep('(surge)|(storm)', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE )))

indices <- setdiff(agrep('(coastal)', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE ),
                  agrep('(surge)|(storm)', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE ))

cl_df_stormData_raw$EVTYPE[indices] <- 'COASTAL FLOOD'

cl_df_stormData_raw$EVTYPE[agrep('tidal flood', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE )] <- 'COASTAL FLOOD'

cl_df_stormData_raw$EVTYPE[agrep('cstl', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE )] <- 'COASTAL FLOOD'
cl_df_stormData_raw$EVTYPE[agrep('beach', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE )] <- 'COASTAL FLOOD'

#----------------------------------------------------------------------
#lakeshore flood

cl_df_stormData_raw$EVTYPE[agrep('lakeshore flood', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE )] <- 'LAKESHORE FLOOD'

cl_df_stormData_raw$EVTYPE[agrep('lake flood', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE )] <- 'LAKESHORE FLOOD'

#--------------------------------------------------------------------
#flash flood 
#includes stream, street, icejam , breakup, minor, highway, snowmelt, 
#run local,rural ?? 
unique(grep('stream|(street)|(icejam)|(highway)|(minor)|(snowmelt)|(break)(local)|(rural)', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, value = TRUE, fixed = FALSE ))

cl_df_stormData_raw$EVTYPE[grep('stream|(street)|(icejam)|(ice jam)|(highway)|(minor)|(snowmelt)|(break)|(local)|(rural)', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE )] <- 'FLASH FLOOD'

unique(grep('flash', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, value = TRUE, fixed = FALSE ))

 setdiff(unique(grep('flash', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, value = TRUE, fixed = FALSE )),
         unique(grep('storm', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, value = TRUE, fixed = FALSE )))
 
indices <-  setdiff(grep('flash', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE,  fixed = FALSE ),
                    grep('storm', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE,  fixed = FALSE ))

 cl_df_stormData_raw$EVTYPE[indices] <- 'FLASH FLOOD'
 
 
 
 #-------------------------------------------------
#flood includes river,major flooding
 #all remaining floods excluding storm (ice or thunder), and flash , coastal,lakeshore
 setdiff(unique(agrep('flood', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, value = TRUE, fixed = FALSE )),
         unique(grep('storm|(flash)|(coastal)|(lake)', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, value = TRUE, fixed = FALSE )))

 indices <-  setdiff(agrep('flood', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE,  fixed = FALSE ),
                     grep('storm|(flash)|(coastal)|(lake)', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE,  fixed = FALSE ))
 
 cl_df_stormData_raw$EVTYPE[indices] <- 'FLOOD'
#-----------------------------------------------------------------------------------------------------------------------------------------------
 
 # search with fuzzy match
 unique(agrep('(hurricane)|(typhoon)', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

 indices <- agrep('(hurricane)|(typhoon)', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE)
 
cl_df_stormData_raw$EVTYPE[indices] <- 'HURRICANE/TYPHOON'

#----------------------------------------------------------------------------------------------------------------------------------------------
# search with fuzzy match
unique(agrep('seiche', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

#-------------------------------------------------------------------------------------------------------------------------
# search with fuzzy match
unique(agrep('sleet', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

indices <- agrep('sleet', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE)

cl_df_stormData_raw$EVTYPE[indices] <- 'SLEET'
#-------------------------------------------------------------------------------------------------------------------------------
# search with fuzzy match
unique(agrep('(hurricane)|(typhoon)', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

indices <- agrep('(hurricane)|(typhoon)', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE)

cl_df_stormData_raw$EVTYPE[indices] <- 'HURRICANE/TYPHOON'
#-------------------------------------------------------------------------------------------------------------------------------
# search with fuzzy match
unique(agrep('ice storm', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

indices <- agrep('ice storm', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE)

cl_df_stormData_raw$EVTYPE[indices] <- 'ICE STORM'

#----------------------------------------------------------------------------------------------------------------------------
# search with fuzzy match
unique(agrep('lake effect snow', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
# search with fuzzy match

indices <- unique(agrep('lake effect snow', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE))


cl_df_stormData_raw$EVTYPE[indices] <- 'LAKE-EFFECT SNOW'
cl_df_stormData_raw$EVTYPE[agrep('lake snow', cl_df_stormData_raw$EVTYPE,  ignore.case = TRUE, fixed = FALSE)] <- 'LAKE-EFFECT SNOW'
#---------------------------------------------------------------------------------------------------------------------------------------

# search with fuzzy match
unique(agrep('lightning', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
#unique(agrep('thunderstorm wind', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

#thunderstorm may arise within 30 mins of lightnining so include it
indices <- unique(agrep('lightning', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE))


cl_df_stormData_raw$EVTYPE[indices] <- 'LIGHTNING'

#--------------------------------------------------------------------------------------------------------------------------------

unique(agrep('marine hail', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
#already cleaned

#--------------------------------------------------------------------------------------------------------------------------------

unique(agrep('marine high wind', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
#already cleaned

#---------------------------------------------------------------------------------------------------------------------
unique(grep('marine thunderstorm wind|marine tstm wind', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
unique(agrep('thunderstorm', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

cl_df_stormData_raw$EVTYPE[grep('marine thunderstorm wind|marine tstm wind', cl_df_stormData_raw$EVTYPE,  ignore.case = TRUE, fixed = FALSE)] <- 'MARINE THUNDERSTORM WIND'


#---------------------------------------------------------------------------------------------------------------------
# search with fuzzy match
unique(agrep('rip current', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
#unique(agrep('damage', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

indices <- unique(agrep('rip current', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE))


cl_df_stormData_raw$EVTYPE[indices] <- 'RIP CURRENT'
#-----------------------------------------------------------------------------------------------------------
# search with fuzzy match

#
#include all tides except except astronomical low tide(another category)
unique(grep('tide', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

unique(grep('surge', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
unique(grep('sea', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

setdiff(grep('tide|surge', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE),
        grep('astronimcal low', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

indices <- setdiff(grep('tide|surge', cl_df_stormData_raw$EVTYPE,  ignore.case = TRUE, fixed = FALSE),
                   grep('astronimcal low', cl_df_stormData_raw$EVTYPE,  ignore.case = TRUE, fixed = FALSE))


cl_df_stormData_raw$EVTYPE[indices] <- 'STORM SURGE/TIDE'
#----------------------------------------------------------------------------------------------------------------------------------------

# search with fuzzy match

#
#exclude marine and thunderstorm
unique(grep('strong wind', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
#unique(grep('wind', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))



setdiff(grep('strong wind', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE),
        grep('marine', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

indices <- setdiff(grep('strong wind', cl_df_stormData_raw$EVTYPE,  ignore.case = TRUE, fixed = FALSE),
                   grep('marine', cl_df_stormData_raw$EVTYPE,  ignore.case = TRUE, fixed = FALSE))


cl_df_stormData_raw$EVTYPE[indices] <- 'STRONG WIND'
#------------------------------------------------------------------------------------------------------------------------------------------------
#exclude marine,strong,non tstm, flash
#thunderstorm or tstm, severe nonsevere, macro micro burst downburst, gustnadoes-whirlwind, damage

unique(grep('wind', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

unique(agrep('thunderstorm', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))


setdiff(unique(grep('thunderstorm', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE)),
       unique(grep('marine|flash|flood', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE)))

indices <- setdiff(grep('thunderstorm', cl_df_stormData_raw$EVTYPE,  ignore.case = TRUE, fixed = FALSE),
                   grep('marine|flash|flood', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE))


cl_df_stormData_raw$EVTYPE[indices] <- 'THUNDERSTORM WIND'

indices <- setdiff(agrep('thunderstorm', cl_df_stormData_raw$EVTYPE,  ignore.case = TRUE, fixed = FALSE),
                   grep('marine|flash|flood', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE))


cl_df_stormData_raw$EVTYPE[indices] <- 'THUNDERSTORM WIND'



#--------------
unique(grep('tstm', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

#unique(grep('wind gust', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

setdiff(unique(grep('tstm', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE)),
unique(grep('marine|non-tstm|non tstm', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE)))

indices <- setdiff(grep('tstm', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE),
                  grep('marine|non-tstm|non tstm', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE))


cl_df_stormData_raw$EVTYPE[indices] <- 'THUNDERSTORM WIND'

#-------------
unique(grep('whirlwind|burst|wind damage|force', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

indices <- grep('whirlwind|burst|wind damage|force', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE)


cl_df_stormData_raw$EVTYPE[indices] <- 'THUNDERSTORM WIND'

#-------------------------------------------------------------------------------------------------------------------------------------------
unique(agrep('tornado', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
#may include waterspout(also a category other than this),landspout, cold air funnel(also a category other than this)

unique(grep('tornado|landspout', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
indices <- grep('tornado|landspout', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE)


cl_df_stormData_raw$EVTYPE[indices] <- 'TORNADO'

indices <- agrep('torndao', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE)
cl_df_stormData_raw$EVTYPE[indices] <- 'TORNADO'

#---------------------------------------------------------------------------------------------------------------------------------------------

unique(agrep('tropical storm', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))


indices <- grep('tropical storm', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE)


cl_df_stormData_raw$EVTYPE[indices] <- 'TROPICAL STORM'

#---------------------------------------------------------------------------------------------------------------------------------------------

unique(agrep('tropical depression', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

#cleaned
#--------------------------------------------------------------------------------------------------------------------------------------------
unique(agrep('waves', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
unique(grep('tsunami', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
unique(grep('sea', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

setdiff(unique(grep('tsunami|wave|sea', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE)),
        unique(grep('unsea|season', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE)))

indices <- setdiff(grep('tsunami|wave|sea', cl_df_stormData_raw$EVTYPE,  ignore.case = TRUE, fixed = FALSE),
                   grep('unsea|season', cl_df_stormData_raw$EVTYPE,  ignore.case = TRUE, fixed = FALSE))

cl_df_stormData_raw$EVTYPE[indices] <- 'TSUNAMI'

#------------------------------------------------------------------------------------------------------------------------------------------

unique(agrep('volcanic', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

indices <- agrep('volcanic', cl_df_stormData_raw$EVTYPE,  ignore.case = TRUE, fixed = FALSE)

cl_df_stormData_raw$EVTYPE[indices] <- 'VOLCANIC ASH'
#-------------------------------------------------------------------------------------------------------------------------------------------


unique(agrep('water spout', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

indices <- agrep('waterspout', cl_df_stormData_raw$EVTYPE,  ignore.case = TRUE, fixed = FALSE)

cl_df_stormData_raw$EVTYPE[indices] <- 'WATERSPOUT'

#-------------------------------------------------------------------------------------------------------------------------------------------


unique(grep('fire', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

indices <- grep('fire', cl_df_stormData_raw$EVTYPE,  ignore.case = TRUE, fixed = FALSE)

cl_df_stormData_raw$EVTYPE[indices] <- 'WILDFIRE'

#-------------------------------------------------------------------------------------------------------------------------------------------

#winter storm includes ice & snow, winter storm

unique(agrep('winter storm', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
unique(agrep('ice', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
unique(agrep('snow', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
unique(agrep('sleet', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
unique(grep('(ICE/SNOW)|(snow/ice)|(snow and ice)', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))




cl_df_stormData_raw$EVTYPE[grep('(ICE/SNOW)|(snow/ice)|(snow and ice)', cl_df_stormData_raw$EVTYPE,  ignore.case = TRUE, fixed = FALSE)] <- 'WINTER STORM'
cl_df_stormData_raw$EVTYPE[agrep('winter storm', cl_df_stormData_raw$EVTYPE,  ignore.case = TRUE, fixed = FALSE)] <- 'WINTER STORM'


#--------------------------------------------------------------------------------------------------------------------------------


#winter weather include mix, blowing snow, freezing,rain , drizzle, snow, ice, glaze

unique(grep('snow', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
unique(grep('ice|glaze|blowing', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
unique(grep('glaze', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
unique(grep('wintry', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
unique(grep('mix', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
unique(grep('winter weather', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))


unique(grep('snow', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
cl_df_stormData_raw$EVTYPE[grep('(mix)|(winter weather)', cl_df_stormData_raw$EVTYPE,  ignore.case = TRUE, fixed = FALSE)] <- 'WINTER WEATHER'

setdiff(unique(grep('ice|glaze|blowing|icy', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE)), 
         unique(grep('ice storm', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE)))

cl_df_stormData_raw$EVTYPE[setdiff(grep('ice|glaze|blowing|icy', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE), 
                                   grep('ice storm', cl_df_stormData_raw$EVTYPE,  ignore.case = TRUE, fixed = FALSE))] <-'WINTER WEATHER'


setdiff(unique(grep('snow', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE)),
        unique(grep('lake|heavy|thunder|record', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE)))

cl_df_stormData_raw$EVTYPE[setdiff(grep('snow', cl_df_stormData_raw$EVTYPE,  ignore.case = TRUE, fixed = FALSE),
        grep('lake|heavy|thunder|record', cl_df_stormData_raw$EVTYPE,  ignore.case = TRUE, fixed = FALSE))] <-'WINTER WEATHER'

#------------------------------------------------------------------------------------------------------------------------------------------

unique(agrep('coastalstorm', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
unique(grep('rainstorm', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
unique(grep('cold', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
unique(grep('cool', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

#remaining severe,record,extreme cold to extreme cold/wind chill
unique(grep('snow', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

#[-----------------------------------------------------------------------------------------------------------------]
# search for chill keyword with fuzzy matching
unique(grep('cold/wind chill', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
unique(grep('chill', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE ))

# exclude from the above results, string that contain 'extreme wind chill' & 'bitter wind chill'
setdiff(unique(agrep('chill', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE)),
        unique(agrep('(extreme) | (bitter)', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE)))

#assign to indices 
#indices <- setdiff(agrep('chill', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE),
                  # agrep('(extreme) | (bitter)', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE))

#cl_df_stormData_raw$EVTYPE[indices] <- 'COLD/WIND CHILL'

setdiff(unique(grep('cold', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE)),
       unique(grep('(extreme)|(severe)|(excessive)|(record)|(un)', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE)))

cl_df_stormData_raw$EVTYPE[setdiff(grep('cold', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE),
                                   grep('(extreme)|(severe)|(excessive)|(record)|(un)', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE))] <- 'COLD/WIND CHILL'

#----------------------------------------------------------------------------------------------------------
# extreme cold/wind chill
#remaining cold except cold/wind chill as extreme
unique(agrep('cold', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE))
unique(grep('cold', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE))
setdiff(unique(grep('cold', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE)),
      unique(grep('cold/wind chill', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE)) )

indices <- setdiff(grep('cold', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE),
                 grep('cold/wind chill', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE))

cl_df_stormData_raw$EVTYPE[indices] <- 'EXTREME COLD/WIND CHILL'

#-------------------------------------------------------------------------------------------------------------------

unique(grep('cool', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE))
cl_df_stormData_raw$EVTYPE[grep('cool spell|(cool and wet)', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE)] <- 'COLD/WIND CHILL'

#remaining cool are extreme

cl_df_stormData_raw$EVTYPE[grep('cool', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE)] <- 'EXTREME COLD/WIND CHILL'
#--------------------------------------------------------------------------------------------------------------------------------------------

unique(agrep('coastal storm', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE))

cl_df_stormData_raw$EVTYPE[agrep('coastal storm', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE)] <- 'STORM SURGE/TIDE'
#--------------------------------------------------------------------------------------------------------------------------------------------

unique(grep('dry|dri', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE))

cl_df_stormData_raw$EVTYPE[grep('dry|dri', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE)] <- 'DROUGHT'

#----------------------------------------------------------------------------------------------------------------

#record warm is excessive heat
unique(grep('record warm', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE))

cl_df_stormData_raw$EVTYPE[grep('record warm', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE)] <- 'EXCESSIVE HEAT'

#unseasonably warmth is heat

unique(grep('warm', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE))

cl_df_stormData_raw$EVTYPE[agrep('warm', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE)] <- 'HEAT'



unique(grep('record high|(high temperature)', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE))

cl_df_stormData_raw$EVTYPE[grep('record high|(high temperature)', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE)] <- 'EXCESSIVE HEAT'

#--------------------------------------------------------------------------------------------------------------------------------------------------------

unique(grep('land', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE))


#/Marine Incidents.
unique(grep('mishap|accident', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE))



unique(grep('freezing', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE))

#---------------------------------------------------------------------------------------------------------------------------------------
#unusually,unseasoanl ,excessive,record ,damaging rain are heavy, not excluding rain with wind, and prolonged rain

setdiff(unique(grep('rain', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE)),
        unique(grep('snow|early|monthly', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE)))

indices <- setdiff(grep('rain', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE),
                   
                   grep('snow|early|monthly', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE))

cl_df_stormData_raw$EVTYPE[indices] <- 'HEAVY RAIN'

#-------------------------------------------------------------------------------------------------------------------------------
unique(agrep('snow', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE))
       
setdiff(unique(agrep('snow', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE)),
        unique(grep('lake', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE)))

cl_df_stormData_raw$EVTYPE[setdiff(agrep('snow', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE),
                           grep('lake', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE))] <- 'HEAVY SNOW'
#------------------------------------------------------------------------------------------------------------------------------------------
unique(grep('temp', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE))

setdiff(unique(grep('temp', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE)),
        unique(grep('low|monthly', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE)))

cl_df_stormData_raw$EVTYPE[setdiff(grep('temp', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE),
                                   grep('low|monthly', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE))] <- 'EXCESSIVE HEAT'

#-------------------------------------------------------------------------------------------------------------------------------------------
cl_df_stormData_raw$EVTYPE[agrep('hypothermia', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE)] <- 'WINTER WEATHER'
#agrep('hypothermia', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE)
#-----------------------------------------------------------------------------------------------------------------------------

#cold wind/chill includes low temp, seasonal
setdiff(unique(agrep('low temp', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE)),
        unique(grep('record|unsea', cl_df_stormData_raw$EVTYPE,value = TRUE, ignore.case = TRUE, fixed = FALSE)))
        
cl_df_stormData_raw$EVTYPE[ setdiff(agrep('low temp', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE),
                                   grep('record|unsea', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE))] <- 'COLD/WIND CHILL'

#extreme cold/wind chill includes unseasonal and record low temp
#unique(agrep('low temp', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE,value = TRUE, fixed = FALSE))

cl_df_stormData_raw$EVTYPE[ agrep('low temp', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE)] <- 'EXTREME COLD/WIND CHILL'

#----------------------------------------------------------------------------------------------------------------------------------------
#unique(agrep('high water', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE,value = TRUE, fixed = FALSE))
cl_df_stormData_raw$EVTYPE[ agrep('high water', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE)] <- 'FLASH FLOOD'
#-------------------------------------------------------------------------------------------------------------------------------------

unique(agrep('summary', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE,value = TRUE, fixed = FALSE))
cl_df_stormData_raw$EVTYPE[ agrep('summary', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE)] <- 'SUMMARY'

#-----------------------------------------------------------------------------------------------------------------------------------------------


unique(agrep('wind', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE,value = TRUE, fixed = FALSE))

setdiff(unique(agrep('wind', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE,value = TRUE, fixed = FALSE)),
        unique(grep('winter|extreme|storm|marine|high|chill|strong|fire', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE,value = TRUE, fixed = FALSE)))

cl_df_stormData_raw$EVTYPE[ setdiff(agrep('wind', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE,fixed = FALSE),
                      grep('winter|extreme|storm|marine|high|chill|strong|fire', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE))] <- 'WIND'

#---------------------------------------------------------------------------------------------------------------------------------------------------


unique(grep('vog', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE,value = TRUE, fixed = FALSE))
cl_df_stormData_raw$EVTYPE[grep('vog', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE)] <- 'FOG'
#----------------------------------------------------------------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------------------------------------------------------

unique(grep('rain', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE,value = TRUE, fixed = FALSE))


setdiff(unique(grep('rain', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE,value = TRUE, fixed = FALSE)),
        unique(grep('heavy', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE,value = TRUE, fixed = FALSE)))

cl_df_stormData_raw$EVTYPE[setdiff(grep('rain', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE,fixed = FALSE),
                                   grep('heavy', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE))] <- 'RAIN'

setdiff(unique(grep('wet', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE,value = TRUE, fixed = FALSE)),
        unique(grep('unseason|excessive|abnormal|extreme', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE,value = TRUE, fixed = FALSE)))

cl_df_stormData_raw$EVTYPE[setdiff(grep('wet', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE,fixed = FALSE),
      grep('unseason|excessive|abnormal|extreme', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE))] <- 'RAIN'



#remaining wet
unique(grep('wet', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE,value = TRUE, fixed = FALSE))

cl_df_stormData_raw$EVTYPE[grep('wet', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE,fixed = FALSE)] <- 'HEAVY RAIN'
#--------------------------------------------------------------------------------------------------------------------------

unique(grep('mishap|accident', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
cl_df_stormData_raw$EVTYPE[grep('mishap|accident', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE)] <- 'MARINE INCIDENT'
#------------------------------------------------------------------------------------------------------------------------------

unique(agrep('turbulence', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
cl_df_stormData_raw$EVTYPE[agrep('turbulence', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE)] <- 'FLOOD'
#------------------------------------------------------------------------------------------------------------------------------

unique(grep('light', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))
cl_df_stormData_raw$EVTYPE[grep('light', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE)] <- 'LIGHTNING'
#=================================================================================================================

setdiff(unique(agrep('flood', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE)),
        unique(grep('flash|coastal|lake', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE)))
      
cl_df_stormData_raw$EVTYPE[setdiff(agrep('flood', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE),
                                   grep('flash|coastal|lake', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE))] <- 'FLOOD'
#=================================================================================================================

unique(agrep('flash', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

cl_df_stormData_raw$EVTYPE[agrep('flash', cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, fixed = FALSE)] <- 'FLASH FLOOD'

#-------------------------------------------------------------------------------------------------------------

unique(grep('other|(south)|(flag)|(pattern)|(metro)', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

cl_df_stormData_raw$EVTYPE[grep('other|(south)|(flag)|(pattern)|(metro)', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE)] <- 'OTHER'

#------------------------------------------------------------------------------------------------------------------------------------


unique(agrep('heavy precipitation', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))


cl_df_stormData_raw$EVTYPE[agrep('heavy precipitation', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE)] <- 'HEAVY PRECIPITATION'

#----------------------------------------------------------------------------------------------------------

unique(agrep('rapidly rise', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

cl_df_stormData_raw$EVTYPE[agrep('rapidly rise', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE)] <- 'FLASH FLOOD'

#-------------------------------------------------------------------------------------------------

unique(grep('excessive precipitation|record precipitation', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

cl_df_stormData_raw$EVTYPE[grep('excessive precipitation|record precipitation', cl_df_stormData_raw$EVTYPE,ignore.case = TRUE, fixed = FALSE)] <- 'HEAVY PRECIPITATION'

#---------------------------------------------------------------------------------------------------------------

unique(agrep('precipitation', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE))

setdiff(unique(grep('precipitation', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE)),
        unique(grep('heavy', cl_df_stormData_raw$EVTYPE, value = TRUE, ignore.case = TRUE, fixed = FALSE)))

cl_df_stormData_raw$EVTYPE[setdiff(grep('precipitation', cl_df_stormData_raw$EVTYPE,  ignore.case = TRUE, fixed = FALSE),
                                   grep('heavy', cl_df_stormData_raw$EVTYPE,  ignore.case = TRUE, fixed = FALSE))] <- 'PRECIPITATION'

#----------------------------------------------------------------------------------------------------------------------------------

#removing set of rows 
#none, ? , apache county, summary
#removing set of rows 
#cl_df_stormData_raw <- cl_df_stormData_raw[ -grep("none|?|apache",df_stormData_raw$EVTYPE, ignore.case = TRUE)]


#---------------------------------------------------------------------

indices <- grep("none", cl_df_stormData_raw$EVTYPE, ignore.case = TRUE)
cl_df_stormData_raw <- cl_df_stormData_raw[-indices]

grep("none", cl_df_stormData_raw$EVTYPE, ignore.case = TRUE, value=TRUE)
