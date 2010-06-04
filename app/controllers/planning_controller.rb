class PlanningController < ApplicationController

  def index
  @essai = 'return {
         events : [
            {
               "id":1,
               "start": new Date(year, month, day, 12),
               "end": new Date(year, month, day, 13, 30),
               "title":"Cours",
               "body": "isjfisdjfisjdfjsdjf"
            },
            {
               "id":2,
               "start": new Date(year, month, day, 14),
               "end": new Date(year, month, day, 14, 45),
               "title":"Evaluation"
            },
            {
               "id":3,
               "start": new Date(year, month, day + 1, 17),
               "end": new Date(year, month, day + 1, 17, 45),
               "title":"Personnel"
            },
            {
               "id":4,
               "start": new Date(year, month, day - 1, 8),
               "end": new Date(year, month, day - 1, 9, 30),
               "title":"Team breakfast"
            },
            {
               "id":5,
               "start": new Date(year, month, day + 1, 14),
               "end": new Date(year, month, day + 1, 15),
               "title":"Product showcase"
            },
            {
               "id":6,
               "start": new Date(year, month, day, 10),
               "end": new Date(year, month, day, 11),
               "title":"I\'m read-only",
               readOnly : true
            },
            {
               "id":7,
               "start": new Date(year, month, day+5, 10),
               "end": new Date(year, month, day+5, 11),
               "title":"I\'m read-only",
               readOnly : true
            },
            {
               "id":8,
               "start": new Date(year, month, day, 12),
               "end": new Date(year, month, day, 13, 30),
               "title":"Personnel",
               "body": "isjfisdjfisjdfjsdjf"
            },

         ]
      };'
    
  end
  def show
    render :text => '<h1 style="color:red;">qqsdsqdqsqqsdsqdqsqqsdsqdqsqqsdsqdqsqqsdsqdqsqqsdsqdqsqqsdsqdqsqqsdsqdqsqqsdsqdqs</h1>'
    end

end
