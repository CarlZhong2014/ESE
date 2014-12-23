*** SMIC SPICE model for 0.18um low leakage 1.8V/5V 1P6M(1P5M, 1P4M) process ***
*** For HSPICE only ***


1. Update History:

      V0.1: Initiate
           
      V1.0: All models (MOS, Diode, Resistor, etc) parameters are re-extracted due to process change.
            All the attachments are updated. 
            In main document, detail information as follows:
            a. Update MOS corner model in section 7.2.2.
            b. Update ring oscillator verification table in section 7.2.3.
            c. Add 1/f noise model in section 7.2.4.
            d. Add non-standard (with LDD) SAB resistor model in section 7.6.
            e. Add MIM capacitance model in section 7.7.
            f. Update MOS comparison table in section 7.8.2 and 7.8.3.
            g. Update ring simulation table in 7.8.4.

      V1.1: Updated RC_N+, RC_P+, RC_N+Poly, RC_P+Poly and RC_Via PCM SPEC in document file Resistance Table (section 7.6).

      V1.2: a.Revised resistor NPOSAB, NPOSAB_NSTD, PPOSAB, PPOSAB_NSTD sub-circuit model in "l018ll_io50_v1p2_res.ckt".
            b.Revised "Comparison Between MOSFET Model Simulation and Measurement Results" table in section 7.8.2.
            c.Revised BJT model parameter CJE, CJC in "l018ll_io50_v1p2_bjt.mdl".
            d.Revised BJT corner parameter DCJE, DCJC in "l018ll_io50_v1p2.lib".
            e.Revised all model card files to version 1.2.
      V1.3: 1.Added eldo format model card files, which include the files of "l018ll_io50_v1p3_eldo.lib", "l018ll_io50_v1p3_eldo.mdl", "l018ll_io50_v1p3_bjt_eldo.mdl", "l018ll_io50_v1p3_res_eldo.mdl", and "l018ll__v1p3_res_eldo.ckt".
            2.Added 3T poly resistor model in section of 7.6 and centered the resistor model to match the PCM SPEC in ¡°l018ll_io50_v1p3_res.mdl¡±, ¡°l018ll_io50_v1p3_res.ckt¡±,¡°l018ll_io50_v1p3_res_spe.mdl¡±,  ¡°l018ll_io50_v1p3_res_spe.ckt¡±, ¡°l018ll_io50_v1p3_res_eldo.mdl¡± and ¡°l018ll_io50_v1p3_res_eldo.ckt¡±.
            3.Revised the corner for the resistor model to match the PCM SPEC in ¡°l018ll_io50_v1p3.lib¡±,  ¡°l018ll_io50_v1p3_spe.lib¡± and ¡°l018ll_io50_v1p3_eldo.lib¡±.
            4.Revised the sheet resistance table, the valid voltage range and recommand width table, square number 's suggestion for SAB resistance and interface resistor table in section of 7.6.
            5.Revised the parameter definition of ¡°temper¡± to directly expression to avoid the limitation of simulator in the files of  ¡°l018ll_io50_v1p3_res.ckt¡± and ¡°l018ll_io50_v1p3_res_eldo.ckt¡±.
            6.Used the file of res.va to replace res.def. 
            7.Revised readme files of "l018ll_io50_v1p3_readme.txt", "l018ll_io50_v1p3_spe_readme.txt" and "l018ll_io50_v1p3_eldo_readme.txt".
            8.Revised the fitting file of "l018ll_fit_D.doc" and added the 3T resistance's fitting plot of Fig.D10 , Fig.D12 , Fig.D14 , Fig.D16 , Fig.D18 and Fig.D20.
            9.Revised the section of 8.1 and 8.3.
           10.Revised all model card files to version 1.3.

2. Files:

      l018ll_io50_v1p3_readme.txt              .... This file!
      l018ll_io50_v1p3.mdl                     .... Model parameters file for MOSFETs and diode
      l018ll_io50_v1p3.lib                     .... Corner values for MOSFETs, BJT, resistors and MIM capacitor
      l018ll_io50_v1p3_res.mdl                 .... Model parameters file for resistors
      l018ll_io50_v1p3_bjt.mdl                 .... Model parameters file for BJT
      l018ll_io50_v1p3_res.ckt                 .... Resistors and MIM capacitor macro model
      l018ll_io50_v1p3_mim.mdl                 .... Model parameters file for MIM capacitor 
      l018ll_io50_interconnect_struct_1.txt    .... Interconnect tables for structure-1 (Parallel lines above a bottom plate)
      l018ll_io50_interconnect_struct_2.txt    .... Interconnect tables for structure-2 (Parallel lines between two plates)
      l018ll_io50_fit_A.doc                    .... Section A of the fitting plots for 0.18um LL model
      l018ll_io50_fit_B.doc                    .... Section B of the fitting plots for 0.18um LL model
      l018ll_io50_fit_C.doc                    .... Section C of the fitting plots for 0.18um LL model
      l018ll_io50_fit_D.doc                    .... Section D of the fitting plots for 0.18um LL model
      l018ll_io50_fit_E.doc                    .... Section E of the fitting plots for 0.18um LL model
      l018ll_io50_fit_F.doc                    .... Section F of the fitting plots for 0.18um LL model
      l018ll_io50_layer.map                    .... GDSII layers definition file
      DIO_NPW18.gds                            .... GDSII file for 1.8V Diode N+/Pwell
      DIO_PNW18.gds                            .... GDSII file for 1.8V Diode P+/Nwell
      DIO_NPW50.gds                            .... GDSII file for 5V Diode N+/Pwell
      DIO_PNW50.gds                            .... GDSII file for 5V Diode P+/Nwell
      DIO_NWPS.gds                             .... GDSII file for Diode Nwell/Pwell
      PNP18A100.gds                            .... GDSII file for 1.8V BJT PNP 10X10
      PNP18A25.gds                             .... GDSII file for 1.8V BJT PNP 5X5
      PNP18A4.gds                              .... GDSII file for 1.8V BJT PNP 2X2

3. How to use SMIC SPICE models in HSPICE:

      Add the following statements to HSPICE netlist.
      
      a. Specify MOS model corner by the '.lib' statement;

         .lib '/xxx/xxx/l018ll_io50_v1p3.lib' TT
                                              ^^ mos model corner

      b. Include MOS, diode, resistor, BJT and MIM model parameters by the '.include' statement;
         
         .include '/xxx/xxx/l018ll_io50_v1p3.mdl'
         
         .include '/xxx/xxx/l018ll_io50_v1p3_res.mdl'  

         .include '/xxx/xxx/l018ll_io50_v1p3_bjt.mdl' 

         .include '/xxx/xxx/l018ll_io50_v1p3_mim.mdl'

      c. Call resistor and MIM macro model subcircuit by the following statement;
         
         .lib '/xxx/xxx/l018ll_io50_v1p3.lib' TT
                                              ^^ mos model corner
         .lib '/xxx/xxx/l018ll_io50_v1p3.lib' RES_TT
                                                  ^^ resistor model corner
         .lib '/xxx/xxx/l018ll_io50_v1p3.lib' MIM_TT
                                                  ^^ mim model corner
         .include '/xxx/xxx/l018ll_io50_v1p3_res.ckt'
          
         then add the following statement in your netlist to define  
	 subcircuit condition you want to simulate. 
         e.g. 
             * nwell resistor under STI        
               X1  rnw_ckt w=1u l=1u
             * mim capacitor
               X2  mim_ckt w=30u l=30u

         Note: For metal resistor, don't need to use the subcircuit file 
               '/xxx/xxx/l018ll_io50_v1p3_res.ckt'.
                      
         Where /xxx/xxx is the directory where mdl and lib files are located.

4. The Capability of Model

       a. MOS Model 
	
        *------------------------------------------------* 
        |     MOSFET type    |  name   |  Lmin  |  Wmin  |
        |================================================| 
        |     1.8V NMOS      |  n18ll  | 0.18um | 0.22um |
        *------------------------------------------------*
        |     1.8V PMOS      |  p18ll  | 0.18um | 0.22um |
        *------------------------------------------------*
        |      5V NMOS       |  n50ll  | 0.5um  | 0.22um |
        *------------------------------------------------*
        |      5V PMOS       |  p50ll  | 0.5um  | 0.22um |
        *------------------------------------------------*
        temperature range:-40C~125C

	b. BJT Model

        *---------------------------------------------------* 
        |      BJT type     |     name      |  Emitter Area |
        |===================================================|
        |   1.8V PNP_10X10  |  pnp18a100ll  |   10*10 um^2  |
        *---------------------------------------------------*  
        |   1.8V PNP_5X5    |  pnp18a25ll   |   5*5 um^2    |
        *---------------------------------------------------* 
        |   1.8V PNP_2X2    |  pnp18a4ll    |   2*2 um^2    |
        *---------------------------------------------------* 
        temperature range:-40C~125C
   
       c. Diode Model               
	
        *---------------------------------------------* 
        |     Diode type     |   name    |    Area    |
        |=============================================| 
        |    1.8V N+/PWELL   | ndio18ll  | 60*60 um^2 |
        *---------------------------------------------*
        |    1.8V P+/NWELL   | pdio18ll  | 60*60 um^2 |
        *---------------------------------------------*
        |     5V N+/PWELL    | ndio50ll  | 60*200 um^2|
        *---------------------------------------------*
        |     5V P+/NWELL    | pdio50ll  | 60*200 um^2|
	*---------------------------------------------*
        |     NWELL/PSUB     |  nwdioll  | 80*120 um^2|
	*---------------------------------------------*
	temperature range:-40C~125C

       d. Resistor Model
	
	*----------------------------------------------------------------------* 
        |             Resistor Type                            |     name      |
        |======================================================|===============|
        |        Silicide N+ Diffusion                         |    rndif      |
        |------------------------------------------------------|---------------| 
        |        Silicide P+ Diffusion                         |    rpdif      |
        |------------------------------------------------------|---------------| 
        |           Silicide N+ Poly                           |     rnpo      |
        |----------------------------------------------------  |---------------| 
        |           Silicide N+ Poly(three terminal)           |    rnpo_3t    |
        |------------------------------------------------------|---------------| 
        |           Silicide P+ Poly                           |     rppo      |
        |------------------------------------------------------|---------------| 
        |           Silicide P+ Poly(three terminal)           |    rppo_3t    |
        |------------------------------------------------------|---------------|
        |        Silicide Nwell under AA                       |    rnwaa      |
        |------------------------------------------------------|---------------| 
        |        Silicide Nwell under STI                      |    rnwsti     |
        |------------------------------------------------------|---------------|
        |        Non-Silicide N+ Diffusion                     |   rndifsab    |
        |------------------------------------------------------|---------------| 
        | Non-Silicide N+ Diffusion (non-standard)             | rndifsab_nstd | 
        |------------------------------------------------------|---------------| 
        |        Non-Silicide P+ Diffusion                     |   rpdifsab    |
        |------------------------------------------------------|---------------|
        | Non-Silicide P+ Diffusion (non-standard)             | rpdifsab_nstd | 
        |------------------------------------------------------|---------------| 
        |          Non-Silicide N+ Poly                        |   rnposab     |
        |------------------------------------------------------|---------------| 
        |          Non-Silicide N+ Poly(three terminal)        |   rnposab_3t  |
        |------------------------------------------------------|---------------|
        |   Non-Silicide N+ Poly (non-standard)                | rnposab_nstd  |
        |------------------------------------------------------|---------------|
        |   Non-Silicide N+ Poly (non-standard)(three terminal)|rnposab_nstd_3t|
        |------------------------------------------------------|---------------| 
        |          Non-Silicide P+ Poly                        |   rpposab     |
        |------------------------------------------------------|---------------| 
        |          Non-Silicide P+ Poly(three terminal)        |  rpposab_3t   |
        |------------------------------------------------------|---------------|
        |   Non-Silicide P+ Poly (non-standard)                | rpposab_nstd  |
        |------------------------------------------------------|---------------|
        |   Non-Silicide P+ Poly (non-standard)(three terminal)|rpposab_nstd_3t|  
        |------------------------------------------------------|---------------| 
        |                  Metal 1                             |      rm1      |
        |------------------------------------------------------|---------------| 
        |                  Metal 2                             |      rm2      |
        |------------------------------------------------------|---------------| 
        |                  Metal 3                             |      rm3      |
        |------------------------------------------------------|---------------|  
        |                  Metal 4                             |      rm4      |
        |------------------------------------------------------|---------------| 
        |                  Metal 5                             |      rm5      |
        |------------------------------------------------------|---------------| 
        |                  Metal 6                             |      rm6      |
        *----------------------------------------------------------------------* 
        temperature range:-40C~125C        

        For more detailed information about resistors, please refer to the resistor table
        at section 7.6 in the main document. 

       e. MIM capacitor Model

          capacitor name    : mim 
          temperature range : -55C~125C

 
5. Corner Model 

       Five model corners are provided for MOSFETs, 
       three model corners are provided for BJT,
       three model corners are provided for resistors,
       three model corners are provided for MIM capacitor.

       They are
        
       ----------------------------------------------------
       MOS       name : corner
       ----------------------------------------------------
                 TT : Typical case
                 SS : Slow case
                 FF : Fast case
                 SNFP : Slow N Fast P case    
                 FNSP : Fast N Slow P case    
       ----------------------------------------------------
       BJT       name : corner
       ----------------------------------------------------
                 BJT_TT : Typical case
                 BJT_SS : Slow case
                 BJT_FF : Fast case 
       ----------------------------------------------------
       Resistor  name : corner
       ----------------------------------------------------
                 RES_TT : Typical case
                 RES_SS : Slow case
                 RES_FF : Fast case
       ----------------------------------------------------
       MIM       name : corner
       ----------------------------------------------------
                 MIM_TT : Typical case
                 MIM_SS : Slow case
                 MIM_FF : Fast case 
       ---------------------------------------------------- 
      