class SubsriberWorker
    include Sneakers::Worker
  
    from_queue "hello", env: nil  
    
    def work(data)
        puts data
    end
  end