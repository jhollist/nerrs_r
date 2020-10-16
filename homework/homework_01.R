# Section 1: Does what?
install.packages("palmerpenguins")
install.packages("randomForest")

# Section 2: Does what?
library(palmerpenguins)
library(randomForest)
library(dplyr)

# Section 3: Does what?
penguins_no_na <- na.omit(penguins)
penguins_cleaned <- select(penguins_no_na, species, bill_length_mm, bill_depth_mm,
                           flipper_length_mm, body_mass_g, body_mass_g)
penguins_rf <- randomForest(species ~ ., data = penguins_cleaned)
penguins_rf

# Section 4: Does what?
plot(penguins_cleaned[,-1], col = penguins_cleaned$species)

