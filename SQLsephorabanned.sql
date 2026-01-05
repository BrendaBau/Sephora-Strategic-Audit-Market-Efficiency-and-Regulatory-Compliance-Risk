

CREATE TABLE dbo.sephora_banned (
    category NVARCHAR(100),         --  Acrylates, parabens, etc
    inci_name NVARCHAR(100),        -- The specific INCI name 
    restriction_level NVARCHAR(50), -- excluded or restricted
    details NVARCHAR(255)           -- Scientific notes
);

INSERT INTO dbo.sephora_banned VALUES 
-- ACRYLATES (Total ban)
('Acrylates', 'Ethyl acrylate', 'Excluded', 'Formulated Without'),

-- ALUMINUM SALTS (Total Ban)
('Aluminum', 'Aluminum Chloride', 'Excluded', 'Formulated Without'),
('Aluminum', 'Aluminum Chlorohydrate', 'Excluded', 'Formulated Without'),

-- BENZOPHENONES (Total Ban)
('Benzophenones', 'Oxybenzone', 'Excluded', 'Formulated Without'),

-- FORMALDEHYDE (Total ban)
('Formaldehyde', 'Formaldehyde', 'Excluded', 'Formulated Without'),
('Formaldehyde', 'DMDM Hydantoin', 'Excluded', 'Formulated Without'),

-- PARABENS (Total ban)
('Parabens', 'Butylparaben', 'Excluded', 'Formulated Without'),

-- SULFATES (Total Ban)
('Sulfates', 'Sodium Lauryl Sulfate', 'Excluded', 'Formulated Without'),

-- MINERAL OILS and PETROLATUM (The nuance)
('Mineral Oil', 'Mineral Oil', 'Excluded', 'Formulated Without'),
('Mineral Oil', 'Petrolatum', 'Restricted Use', 'Allowed if USP Grade'),

-- PHENOXYETHANOL (The percentage rule)
('Preservatives', 'Phenoxyethanol', 'Restricted Use', 'Allowed if <1%'),

-- SILICONES (The environmental rule)
('Silicones', 'Cyclotetrasiloxane', 'Excluded', 'Prohibited'),
('Silicones', 'Cyclopentasiloxane', 'Restricted Use', 'Limit <0.1%');