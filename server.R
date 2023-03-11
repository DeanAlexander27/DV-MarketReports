function(input, output) { 
  
  output$progress2022 <- renderPlotly({
    
    datasetsales <- dataset1 %>% 
      group_by(key_figures,year,month) %>% 
      summarise(total = sum(value)) %>% 
      filter(key_figures=="Sales") 
    
    datasettotalstock <- dataset1 %>% 
      group_by(key_figures,year,month) %>% 
      summarise(total = sum(value)) %>% 
      filter(key_figures=="Total Stock") 
    
    datasetmandist <- dataset1 %>% 
      group_by(key_figures,year,month) %>% 
      summarise(total = sum(value)) %>% 
      filter(key_figures=="MANUF DISTRIBUTION") 
    
    datasettotalstock <- datasettotalstock %>% 
      mutate(label=glue("Total Stock {month} {year} :
                    {total} unit"))
    
    datasetsales <- datasetsales %>% 
      mutate(label = glue ("Total Sales {month} {year} :
                       {total} unit "))
    
    datasetmandist <- datasetmandist %>% 
      mutate(label = glue ("Total Manufacturing Distribution
                       {month} {year} : {total} unit"))
    
    # Visualisasi 1
    grafik <- datasettotalstock %>% ggplot() +
      geom_col(data = datasettotalstock,mapping = aes(x = month, y = total, fill = as.factor(year), text=label),position = 'dodge') +
      scale_fill_manual(name = NULL ,values = c('#d0cdd7', '#acb0bd', '#416165', '#0b3948')) +
      geom_line(data = datasetmandist, aes(x = month, y = total, color = factor(year), group = year), size = 1) +
      geom_point(data = datasetmandist, mapping = aes(x = month, y = total, color = factor(year),text=label)) +
      scale_color_brewer(palette = "Set3") +
      geom_line(data = datasetsales, aes(x = month, y = total, color = factor(year), group = year),linetype = 4,size = 1) +
      geom_point(data = datasetsales, mapping = aes(x = month, y = total, color = factor(year),text=label)) +
      scale_colour_manual(values = c("#fe8181", "#fe5757", "#fe2e2e", "#b62020")) +
      labs(title = 'PT.A Progress Year on Year (2019 - 2022)', col = "Year") +
      theme_algoritma
   
    ggplotly(grafik,tooltip='text') 
  })

  output$progress2022.1 <- renderPlotly({
    
    datasetsales <- dataset1 %>% 
      group_by(key_figures,year,month) %>% 
      summarise(total = sum(value)) %>% 
      filter(key_figures=="Sales") 
    
    datasettotalstock <- dataset1 %>% 
      group_by(key_figures,year,month) %>% 
      summarise(total = sum(value)) %>% 
      filter(key_figures=="Total Stock") 
    
    datasetmandist <- dataset1 %>% 
      group_by(key_figures,year,month) %>% 
      summarise(total = sum(value)) %>% 
      filter(key_figures=="MANUF DISTRIBUTION")
    
    dataset_long <- dataset1 %>% 
      group_by(key_figures,Tahun) %>% 
      summarise(total = sum(value))
    
    dataset_long1 <- dataset_long %>% 
      pivot_wider(names_from = "key_figures",
                  values_from = "total")
    
    datasettotalstock <- datasettotalstock %>% 
      mutate(label=glue("Total Stock {month} {year} :
                    {total} unit"))
    
    datasetsales <- datasetsales %>% 
      mutate(label = glue ("Total Sales {month} {year} :
                       {total} unit "))
    
    datasetmandist <- datasetmandist %>% 
      mutate(label = glue ("Total Manufacturing Distribution
                       {month} {year} : {total} unit"))
    
    dataset_long <- dataset1 %>%
      group_by(key_figures,year,month) %>% 
      summarise(total = sum(value)) %>% 
      pivot_wider(names_from = "key_figures",
                  values_from = "total") %>% 
      mutate(label = glue ("Total Sales {month} {year} : {Sales} unit
                            Total Man. Dist. {month} {year} : {`MANUF DISTRIBUTION`} unit"))
  
    # Visualisasi 2
    dist <- dataset_long %>% 
      ggplot()+
      geom_jitter(mapping = aes(x= Sales, y= `MANUF DISTRIBUTION`, text = label))+
      geom_smooth(mapping = aes(x= Sales, y= `MANUF DISTRIBUTION`))+
      theme_algoritma+
      scale_color_brewer(palette="Set3")+
      labs(title = 'PT.A Progress Year on Year (2019 - 2022)')+
      theme(legend.position = "none")
    
    ggplotly(dist, tooltip="text")
  })
  
  # Visualisasi 3
  output$progress2022.2 <- renderPlotly({
    datasetsales2 <- dataset1 %>% 
      group_by(key_figures,year,month, Category) %>% 
      summarise(total = sum(value)) %>%
      filter(Category == input$input3) %>% 
       
      filter(key_figures %in% "Sales") %>% 
      filter(year ==  input$input1) %>% 
      mutate(label = glue ("Total Sales {Category}
                       {month} {year} : {total} unit")) %>%  
      ggplot()+
      geom_line(mapping = aes(x = month, y = total,group = Category, text = label))+
      geom_point(mapping = aes(x = month, y = total,group = Category, text = label))+
      labs(title = "Sales Category Year on Year", )+
      scale_color_brewer(palette = 1)+
      theme_algoritma
    
    ggplotly(datasetsales2, tooltip ='text') })
  
  # Visualisasi 4
  output$progress2022.3 <- renderPlotly({
    datasetmandistnew2 <- dataset1 %>% 
      group_by(key_figures,year,month,Category) %>% 
      summarise(total = sum(value)) %>%
      filter(Category == input$input3) %>%
      
      filter(key_figures == "MANUF DISTRIBUTION") %>% 
      filter(year ==  input$input1) %>%
      mutate(label = glue ("Total Man. Dist {Category}
                       {month} {year} : {total} unit")) %>% 
      ggplot()+
      geom_line(mapping = aes(x = month, y = total,group = Category, text = label))+
      geom_point(mapping = aes(x = month, y = total,group = Category, text = label))+
      labs(title = "Manufacturing Distribution")+
      theme_algoritma
    
    ggplotly(datasetmandistnew2,tooltip = 'text') })
  
  # Visualisasi 5 
  output$progress2022.4 <- renderPlotly({
    datasetint1 <- dataset1 %>% 
      group_by(key_figures,year,month,Category) %>% 
      summarise(total = sum(value)) %>%
      filter(Category == input$input3) %>%
       
      filter(key_figures == "Intransit 1") %>% 
      filter(year ==  input$input1) %>%
      mutate(label = glue ("Total Intransit 1 {Category}
                       {month} {year} : {total} unit")) %>% 
      ggplot()+
      geom_line(mapping = aes(x = month, y = total,group = Category, text = label))+
      geom_point(mapping = aes(x = month, y = total,group = Category, text = label))+
      labs(title = "Intransit 1")+
      theme_algoritma
    
    ggplotly(datasetint1, tooltip='text') })
  
  # Visualisasi 6  
  output$progress2022.5 <- renderPlotly({
    datasettotalstock1 <- dataset1 %>% 
      group_by(key_figures,year,month,Category) %>% 
      summarise(total = sum(value)) %>%
      filter(Category == input$input3) %>%
       
      filter(key_figures == "Total Stock") %>% 
      filter(year ==  input$input1) %>%
      mutate(label = glue ("Total Stock {Category}
                       {month} {year} : {total} unit")) %>% 
      ggplot()+
      geom_col(mapping = aes(x = month, y = total,fill = year, text = label), position = 'dodge')+
      labs(title = "PT.A Total Stock")+
      theme(legend.position = "none") +
      theme_algoritma
    
    ggplotly(datasettotalstock1, tooltip = 'text') })
  
  # Visualisasi 7 
  output$progress2022.6 <- renderPlotly({
    datasetstockretail <- dataset1 %>% 
      group_by(key_figures,year,month,Category) %>% 
      summarise(total = sum(value)) %>%
      filter(Category == input$input3) %>%
       
      filter(key_figures == "Stock Retail") %>% 
      filter(year ==  input$input1) %>%
      mutate(label = glue ("Total Stock Retail {Category}
                       {month} {year} : {total} unit")) %>%
      ggplot()+
      geom_col(mapping = aes(x = month, y = total,fill = year,text = label),position = 'dodge')+
      labs(title = "Stock Retail")+
      theme(legend.position = "none") +
      theme_algoritma
    
    ggplotly(datasetstockretail, tooltip = 'text') })
  
  output$table_data <- renderDataTable({datatable(dataset1, options = list(scrollx = T))})
    
    

  
  
  
}
