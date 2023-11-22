CREATE OR ALTER FUNCTION
    dbo.PrincipalPayment_Inline
(
    @Rate float,
    @Period integer,
    @Periods integer,
    @Present float,
    @Future float,
    @Type integer
)
RETURNS table
AS
RETURN
/*
For support, head over to GitHub:
https://github.com/erikdarlingdata/DarlingData
*/
    SELECT
        PrincipalPayment =
            (
                (
                    SELECT
                        p.Payment
                    FROM dbo.Payment_Inline
                    (
                        @Rate,
                        @Periods,
                        @Present,
                        @Future,
                        @Type
                    ) AS  p
                )
                 -
                (
                    SELECT
                        i.InterestPayment
                    FROM dbo.InterestPayment_Inline
                    (
                        @Rate,
                        @Period,
                        @Periods,
                        @Present,
                        @Future,
                        @Type
                    ) AS i
                )
            );
GO