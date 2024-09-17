-------------------------------------------------
-- Names : Chase, Million, Alek, Josh
-- Team B
-- Capstone 
-- --------------------------------------------------------------------------------
USE SobeeYou;     -- Get out of the master database
SET NOCOUNT ON;
-- --------------------------------------------------------------------------------
--						Sobee You Tables
-- --------------------------------------------------------------------------------
IF OBJECT_ID ('TFlavors')					IS NOT NULL DROP TABLE TFlavors
IF OBJECT_ID ('TUserRoles')					IS NOT NULL DROP TABLE TUserRoles
IF OBJECT_ID ('TAdmins')					IS NOT NULL DROP TABLE TAdmins
IF OBJECT_ID ('TOrders')					IS NOT NULL DROP TABLE TOrders
IF OBJECT_ID ('TProductRecommendations')	IS NOT NULL DROP TABLE TProductRecommendations
IF OBJECT_ID ('TCustomerServiceTickets')	IS NOT NULL DROP TABLE TCustomerServiceTickets
IF OBJECT_ID ('TTicketStatus')				IS NOT NULL DROP TABLE TTicketStatus
IF OBJECT_ID ('TTicketCategories')			IS NOT NULL DROP TABLE TTicketCategories
IF OBJECT_ID ('TInteractions')				IS NOT NULL DROP TABLE TInteractions
IF OBJECT_ID ('TPermissions')				IS NOT NULL DROP TABLE TPermissions
IF OBJECT_ID ('TFavorites')					IS NOT NULL DROP TABLE TFavorites
IF OBJECT_ID ('TShoppingCarts')				IS NOT NULL DROP TABLE TShoppingCarts
IF OBJECT_ID ('TCoupons')					IS NOT NULL DROP TABLE TCoupons
IF OBJECT_ID ('TPromotions')				IS NOT NULL DROP TABLE TPromotions
IF OBJECT_ID ('TShippingMethods')			IS NOT NULL DROP TABLE TShippingMethods
IF OBJECT_ID ('TPaymentMethods')			IS NOT NULL DROP TABLE TPaymentMethods
IF OBJECT_ID ('TRewardsPoints')				IS NOT NULL DROP TABLE TRewardsPoints
IF OBJECT_ID ('TRewardsTransactions')		IS NOT NULL DROP TABLE TRewardsTransactions
IF OBJECT_ID ('TOrdersProducts')			IS NOT NULL DROP TABLE TOrdersProducts
IF OBJECT_ID ('TProductImages')				IS NOT NULL DROP TABLE TProductImages
IF OBJECT_ID ('TRewardsOptions')			IS NOT NULL DROP TABLE TRewardsOptions
IF OBJECT_ID ('TReviews')					IS NOT NULL DROP TABLE TReviews
IF OBJECT_ID ('TShippingStatus')			IS NOT NULL DROP TABLE TShippingStatus
IF OBJECT_ID ('TGenders')					IS NOT NULL DROP TABLE TGenders
IF OBJECT_ID ('TRaces')						IS NOT NULL DROP TABLE TRaces
IF OBJECT_ID ('TStates')					IS NOT NULL DROP TABLE TStates
IF OBJECT_ID ('TCities')					IS NOT NULL DROP TABLE TCities
IF OBJECT_ID ('TOrderItems')				IS NOT NULL DROP TABLE TOrderItems
IF OBJECT_ID ('TTransactionTypes')			IS NOT NULL DROP TABLE TTransactionTypes
IF OBJECT_ID ('TProducts')					IS NOT NULL DROP TABLE TProducts
IF OBJECT_ID ('TIngredients')				IS NOT NULL DROP TABLE TIngredients
IF OBJECT_ID ('TDrinkCategories')			IS NOT NULL DROP TABLE TDrinkCategories
IF OBJECT_ID ('TUsers')						IS NOT NULL DROP TABLE TUsers

-- --------------------------------------------------------------------------------
--						Create Tables
-- --------------------------------------------------------------------------------
CREATE TABLE TFlavors
(
	 intFlavorID			INTEGER			NOT NULL
	,strFlavor				VARCHAR(255)	NOT NULL
	,CONSTRAINT TFlavors_PK PRIMARY KEY ( intFlavorID )
)

CREATE TABLE TCities
(
	 intCityID			INTEGER			NOT NULL
	,strCity			VARCHAR(255)	NOT NULL
	,CONSTRAINT TCities_PK PRIMARY KEY ( intCityID )
)

CREATE TABLE TStates
(
	 intStateID			INTEGER			NOT NULL
	,strState			VARCHAR(255)	NOT NULL
	,CONSTRAINT TStates_PK PRIMARY KEY ( intStateID )
)

CREATE TABLE TRaces
(
	 intRaceID			INTEGER			NOT NULL
	,strRace			VARCHAR(255)	NOT NULL
	,CONSTRAINT TRaces_PK PRIMARY KEY ( intRaceID )
)

CREATE TABLE TGenders
(
	 intGenderID		INTEGER			NOT NULL
	,strGender			VARCHAR(255)	NOT NULL
	,CONSTRAINT TGenders_PK PRIMARY KEY ( intGenderID )
)

CREATE TABLE TShippingStatus
(	
	 intShippingStatusID			INTEGER			NOT NULL
	,strShippingStatus				VARCHAR(255)	NOT NULL
	,CONSTRAINT TShippingStatus_PK PRIMARY KEY ( intShippingStatusID )
)

CREATE TABLE TDrinkCategories
(	
	 intDrinkCategoryID				INTEGER			NOT NULL
	,strName						VARCHAR(255)	NOT NULL
	,strDescription					VARCHAR(255)	NOT NULL
	,CONSTRAINT TDrinkCategories_PK PRIMARY KEY ( intDrinkCategoryID )
)

CREATE TABLE TRewardsPoints
(	
	 intRewardsPointsID				INTEGER			NOT NULL
	,intUserID						INTEGER			NOT NULL
	,strPointsBalance				VARCHAR(255)	NOT NULL
	,strTotalPointsEarned			VARCHAR(255)	NOT NULL
	,strTotalPointsRedeemed			VARCHAR(255)	NOT NULL
	,CONSTRAINT TRewardsPoints_PK PRIMARY KEY ( intRewardsPointsID )
)

CREATE TABLE TRewardsOptions
(	
	 intRewardsOptionsID			INTEGER			NOT NULL
	,strOptionName					VARCHAR(255)	NOT NULL
	,strPointsRequired				VARCHAR(255)	NOT NULL
	,strDescription					VARCHAR(255)	NOT NULL
	,CONSTRAINT TRewardsOptions_PK PRIMARY KEY ( intRewardsOptionsID )
)


CREATE TABLE TTransactionTypes
(	
	 intTransactionTypeID				INTEGER			NOT NULL
	,strTransactionType					VARCHAR(255)	NOT NULL
	,CONSTRAINT TTransactionTypes_PK PRIMARY KEY ( intTransactionTypeID )
)

CREATE TABLE TRewardsTransactions
(	
	 intRewardsTransactionID		INTEGER			NOT NULL
	,intUserID						INTEGER			NOT NULL
	,intTransactionTypeID			INTEGER			NOT NULL
	,dtmTransactionDate 			DATETIME		NOT NULL
	,strPointAmount					VARCHAR(255)	NOT NULL
	,CONSTRAINT TRewardsTransactions_PK PRIMARY KEY ( intRewardsTransactionID )
)

CREATE TABLE TReviews
(	
	 intReviewID				INTEGER			NOT NULL
	,intUserID					INTEGER			NOT NULL
	,intProductID				INTEGER			NOT NULL
	,strReviewText				VARCHAR(1000)	NOT NULL
	,strRating					VARCHAR(255)	NOT NULL
	,dtmReviewDate 				DATETIME		NOT NULL
	,CONSTRAINT TReviews_PK PRIMARY KEY ( intReviewID )
)
-- --------------------------------------------------------------------------------

CREATE TABLE TProductImages
(	
	 intProductImageID				INTEGER			NOT NULL
	,strProductImageURL				VARCHAR(1000)	NOT NULL
	,CONSTRAINT TProductImages_PK PRIMARY KEY ( intProductImageID )
)
-- --------------------------------------------------------------------------------

CREATE TABLE TIngredients
(	
	 intIngredientID			INTEGER			NOT NULL
	,strIngredient				VARCHAR(255)	NOT NULL
	,CONSTRAINT TIngredients_PK PRIMARY KEY ( intIngredientID )
)
-- --------------------------------------------------------------------------------

CREATE TABLE TOrdersProducts
(	
	 intOrdersProductID			INTEGER			NOT NULL
	 ,intProductID				INTEGER			NOT NULL
	,strOrdersProduct			VARCHAR(255)	NOT NULL
	,CONSTRAINT TOrdersProducts_PK PRIMARY KEY ( intOrdersProductID )
)
-- --------------------------------------------------------------------------------

CREATE TABLE TPaymentMethods
(	
	 intPaymentMethodID					INTEGER			NOT NULL
	,strCreditCardDetails			VARCHAR(255)	NOT NULL
	,strBillingAddress				VARCHAR(255)	NOT NULL
	,strDescription					VARCHAR(255)	NOT NULL
	,CONSTRAINT TPaymentMethods_PK PRIMARY KEY ( intPaymentMethodID )
)
-- --------------------------------------------------------------------------------

CREATE TABLE TShippingMethods
(	
	 intShippingMethodID			INTEGER			NOT NULL
	,strShippingName				VARCHAR(255)	NOT NULL
	,strBillingAddress				VARCHAR(255)	NOT NULL
	,dtmEstimatedDelivery			DATETIME		NOT NULL
	,strCost						VARCHAR(255)	NOT NULL
	,CONSTRAINT TShippingMethods_PK PRIMARY KEY ( intShippingMethodID )
)
-- --------------------------------------------------------------------------------

CREATE TABLE TPromotions
(	
	 intPromotionID					INTEGER			NOT NULL
	,strPromoCode					VARCHAR(255)	NOT NULL
	,strDiscountPercentage			VARCHAR(255)	NOT NULL
	,dtmExpirationDate				DATETIME		NOT NULL
	,CONSTRAINT TPromotions_PK PRIMARY KEY ( intPromotionID )
)
-- --------------------------------------------------------------------------------

CREATE TABLE TCoupons 
(	
	 intCouponID					INTEGER			NOT NULL
	,strCouponCode					VARCHAR(255)	NOT NULL
	,strDiscountAmount				VARCHAR(255)	NOT NULL
	,dtmExpirationDate				DATETIME		NOT NULL
	,CONSTRAINT TCoupons_PK PRIMARY KEY ( intCouponID )
)
-- --------------------------------------------------------------------------------

CREATE TABLE TShoppingCarts
(	
	 intShoppingCartID				INTEGER			NOT NULL
	,strCouponCode					VARCHAR(255)	NOT NULL
	,strDiscountAmount				VARCHAR(255)	NOT NULL
	,dtmExpirationDate				DATETIME		NOT NULL
	,CONSTRAINT TShoppingCarts_PK PRIMARY KEY ( intShoppingCartID )
)
-- --------------------------------------------------------------------------------

CREATE TABLE TFavorites
(	
	 intFavoriteID					INTEGER			NOT NULL
	,strFavorite					VARCHAR(255)	NOT NULL
	,intUserID						INTEGER			NOT NULL
	,intProductID					INTEGER			NOT NULL
	,dtmDateAdded					DATETIME		NOT NULL
	,CONSTRAINT TFavorites_PK PRIMARY KEY ( intFavoriteID )
)
-- --------------------------------------------------------------------------------

CREATE TABLE TPermissions 
(	
	 intPermissionID					INTEGER			NOT NULL
	,strPermissionName					VARCHAR(255)	NOT NULL
	,strDescription						VARCHAR(255)	NOT NULL
	,CONSTRAINT TPermissions_PK PRIMARY KEY ( intPermissionID )
)
-- --------------------------------------------------------------------------------

CREATE TABLE TTicketCategories 
(	
	 intTicketCategoryID			INTEGER			NOT NULL
	,strTicketCategory				VARCHAR(255)	NOT NULL
	,CONSTRAINT TTicketCategories_PK PRIMARY KEY ( intTicketCategoryID )
)
-- --------------------------------------------------------------------------------

CREATE TABLE TTicketStatus
(	
	 intTicketStatusID			INTEGER			NOT NULL
	,strTicketStatus			VARCHAR(255)	NOT NULL
	,CONSTRAINT TTicketStatus_PK PRIMARY KEY ( intTicketStatusID )
)
-- --------------------------------------------------------------------------------

CREATE TABLE TCustomerServiceTickets 
(	
	 intCustomerServiceTicketID			INTEGER			NOT NULL
	,intUserID							INTEGER			NOT NULL
	,intTicketCategoryID				INTEGER			NOT NULL
	,intTicketStatusID					INTEGER			NOT NULL
	,dtmTimeOfSubmission				DATETIME		NOT NULL
	,strDescription						VARCHAR(255)	NOT NULL
	,CONSTRAINT TCustomerServiceTickets_PK PRIMARY KEY ( intCustomerServiceTicketID )
)
-- --------------------------------------------------------------------------------

CREATE TABLE TInteractions
(	
	 intInteractionID			INTEGER			NOT NULL
	,strName					VARCHAR(255)	NOT NULL
	,strDescription				VARCHAR(255)	NOT NULL
	,CONSTRAINT TInteractions_PK PRIMARY KEY ( intInteractionID )
)

CREATE TABLE TProductRecommendations 
(	
	 intProductRecommendationID			INTEGER			NOT NULL
	,intUserID							INTEGER			NOT NULL
	,intProductID						INTEGER			NOT NULL
	,intInteractionID					INTEGER			NOT NULL
	,dtmTimeOfRecommendation			DATETIME		NOT NULL
	,strRelevantScore					VARCHAR(255)	NOT NULL
	,CONSTRAINT TProductRecommendations_PK PRIMARY KEY ( intProductRecommendationID )
)
-- --------------------------------------------------------------------------------

CREATE TABLE TOrderItems
(	
	 intOrder_ItemsID			INTEGER			NOT NULL
	,strOrder_Items				VARCHAR(255)	NOT NULL
	,CONSTRAINT TOrderItems_PK PRIMARY KEY ( intOrder_ItemsID )
)

CREATE TABLE TOrders
(	
	 intOrderID				INTEGER			NOT NULL
	,intUserID				INTEGER			NOT NULL
	,intProductID			INTEGER			NOT NULL
	,intOrder_ItemsID		INTEGER			NOT NULL
	,dtmOrdeDate			DATETIME		NOT NULL
	,strTotalPrice			VARCHAR(255)	NOT NULL
	,intShippingStatusID	INTEGER			NOT NULL
	,CONSTRAINT TOrders_PK PRIMARY KEY ( intOrderID )
)

CREATE TABLE TProducts
(	
	 intProductID			INTEGER			NOT NULL
	,strName				VARCHAR(255)	NOT NULL
	,strDescription			VARCHAR(255)	NOT NULL
	,strPrice				VARCHAR(255)	NOT NULL
	,strQuantity_Available	VARCHAR(255)	NOT NULL
	,intDrinkCategoryID		INTEGER			NOT NULL
	,intIngredientID		INTEGER			NOT NULL
	,CONSTRAINT TProducts_PK PRIMARY KEY ( intProductID )
)
-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------

CREATE TABLE TAdmins
(	
	 intAdminID					INTEGER			NOT NULL
	,strAdminName				VARCHAR(255)	NOT NULL
	,CONSTRAINT TAdmins_PK PRIMARY KEY ( intAdminID )
)
-- --------------------------------------------------------------------------------

CREATE TABLE TUserRoles
(	
	 intUserRoleID					INTEGER			NOT NULL
	,strRole_Description			VARCHAR(255)	NOT NULL
	,intUserID						INTEGER			NOT NULL
	,CONSTRAINT TUserRoles_PK PRIMARY KEY ( intUserRoleID )
)
-- --------------------------------------------------------------------------------

CREATE TABLE TUsers
(	
	 intUserID				INTEGER			NOT NULL
	,strUserName			VARCHAR(255)	NOT NULL
	,strShippingAddress		VARCHAR(255)	NOT NULL
	,strEmail				VARCHAR(255)	NOT NULL
	,strPassword			VARCHAR(255)	NOT NULL
	,CONSTRAINT TUsers_PK PRIMARY KEY ( intUserID )
)


-- --------------------------------------------------------------------------------
--						Referential Integrity 
-- --------------------------------------------------------------------------------
-- -	-----							------						---------
-- 1	TOrders							TUsers						intUserID
-- 2	TProductRecommendations			TUsers						intUserID
-- 3	TProductRecommendations			TProducts					intProductID
-- 4	TCustomerServiceTickets			TUsers						intUserID
-- 5	TCustomerServiceTickets			TTicketCategories			intTicketCategoryID
-- 6	TCustomerServiceTickets			TTicketStatus				intTicketStatusID
-- 7	TReviews						TUsers						intUserID
-- 8	TReviews						TProducts					intProductID
-- 9	TOrderProducts					TProducts					intProductID
-- 10	TProducts						TProducts					intProductID
-- 10	TFavorites						TUsers						intUserID
-- 10	TFavorites						TProducts					intProductID
-- 10	TOrders							TProducts					intProductID
-- 10	TOrders							TOrderItems					intOrder_ItemID
-- 10	TRewardsPoints					TUsers						intUserID




-- -------------------------------------------------------------------------------
----1
--ALTER TABLE TCustomers	 ADD CONSTRAINT TCustomers_TStates_FK 
--FOREIGN KEY ( intStateID ) REFERENCES TStates (intStateID ) ON DELETE CASCADE
----1
ALTER TABLE TOrders	 ADD CONSTRAINT TOrders_TUsers_FK 
FOREIGN KEY ( intUserID ) REFERENCES TUsers (intUserID) ON DELETE CASCADE

----2
ALTER TABLE TProductRecommendations	 ADD CONSTRAINT TProductRecommendations_TUsers_FK 
FOREIGN KEY ( intUserID ) REFERENCES TUsers (intUserID) ON DELETE CASCADE

----3
ALTER TABLE TProductRecommendations	 ADD CONSTRAINT TProductRecommendations_TProducts_FK 
FOREIGN KEY ( intProductID ) REFERENCES TProducts (intProductID) ON DELETE CASCADE

----4
ALTER TABLE TCustomerServiceTickets	 ADD CONSTRAINT TCustomerServiceTickets_TUsers_FK 
FOREIGN KEY ( intUserID ) REFERENCES TUsers (intUserID) ON DELETE CASCADE

----5
ALTER TABLE TCustomerServiceTickets	 ADD CONSTRAINT TCustomerServiceTickets_TTicketCategories_FK 
FOREIGN KEY ( intTicketCategoryID ) REFERENCES TTicketCategories (intTicketCategoryID) ON DELETE CASCADE

----6
ALTER TABLE TCustomerServiceTickets	 ADD CONSTRAINT TCustomerServiceTickets_TTicketStatus_FK 
FOREIGN KEY ( intTicketStatusID ) REFERENCES TTicketStatus (intTicketStatusID) ON DELETE CASCADE

----7
ALTER TABLE TReviews  ADD CONSTRAINT TReviews_TUsers_FK 
FOREIGN KEY ( intUserID ) REFERENCES TUsers (intUserID) ON DELETE CASCADE

----8
ALTER TABLE TReviews  ADD CONSTRAINT TReviews_TProducts_FK 
FOREIGN KEY ( intProductID ) REFERENCES TProducts (intProductID) ON DELETE CASCADE

----9
ALTER TABLE TOrdersProducts  ADD CONSTRAINT TOrdersProducts_TProducts_FK 
FOREIGN KEY ( intProductID ) REFERENCES TProducts (intProductID) ON DELETE CASCADE

----10
ALTER TABLE TProducts	 ADD CONSTRAINT TProducts_TDrinkCategories_FK 
FOREIGN KEY ( intDrinkCategoryID ) REFERENCES TDrinkCategories (intDrinkCategoryID) ON DELETE CASCADE

----11
ALTER TABLE TProducts	 ADD CONSTRAINT TProducts_TIngredients_FK 
FOREIGN KEY ( intIngredientID ) REFERENCES TIngredients (intIngredientID) ON DELETE CASCADE

----11
ALTER TABLE TFavorites	 ADD CONSTRAINT TFavorites_TUsers_FK 
FOREIGN KEY ( intUserID ) REFERENCES TUsers (intUserID) ON DELETE CASCADE

----11
ALTER TABLE TFavorites	 ADD CONSTRAINT TFavorites_TProducts_FK 
FOREIGN KEY ( intProductID ) REFERENCES TProducts (intProductID) ON DELETE CASCADE

----11
ALTER TABLE TOrders	 ADD CONSTRAINT TOrders_TProducts_FK 
FOREIGN KEY ( intProductID ) REFERENCES TProducts (intProductID) ON DELETE CASCADE

----11
ALTER TABLE TOrders	 ADD CONSTRAINT TOrders_TOrderItems_FK 
FOREIGN KEY ( intOrder_ItemsID ) REFERENCES TOrderItems (intOrder_ItemsID) ON DELETE CASCADE

----7
ALTER TABLE TRewardsPoints  ADD CONSTRAINT TRewardsPoints_TUsers_FK 
FOREIGN KEY ( intUserID ) REFERENCES TUsers (intUserID) ON DELETE CASCADE

----7
ALTER TABLE TRewardsTransactions  ADD CONSTRAINT TRewardsTransactions_TTransactionTypes_FK 
FOREIGN KEY ( intTransactionTypeID ) REFERENCES TTransactionTypes (intTransactionTypeID) ON DELETE CASCADE

ALTER TABLE TProductRecommendations  ADD CONSTRAINT TProductRecommendations_TInteractions_FK 
FOREIGN KEY ( intInteractionID ) REFERENCES TInteractions (intInteractionID) ON DELETE CASCADE
