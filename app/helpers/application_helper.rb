module ApplicationHelper
    def btn_primary
        'inline-block rounded bg-indigo-600 px-4 py-2 text-sm font-medium text-white transition duration-150 ease-in-out hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2'
    end

    def btn_secondary
        'inline-block rounded bg-blue-500 px-4 py-2 text-sm font-medium text-white transition duration-150 ease-in-out hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-400 focus:ring-offset-2'
    end

    def btn_tertiary
        'inline-block rounded bg-green-500 px-4 py-2 text-sm font-medium text-white transition duration-150 ease-in-out hover:bg-green-600 focus:outline-none focus:ring-2 focus:ring-green-400 focus:ring-offset-2'
    end

    def btn_disabled
        'inline-block rounded bg-gray-300 px-4 py-2 text-sm font-medium text-gray-500 cursor-not-allowed'
    end

    def btn_class
        'inline-block rounded border border-indigo-600 bg-indigo-600 px-12 py-3 text-sm font-medium text-white hover:bg-transparent hover:text-indigo-600 focus:outline-none focus:ring active:text-indigo-500'
    end

    def btn_class_small
        'inline-block rounded border border-indigo-600 bg-indigo-600 px-12 py-3 text-xs font-medium text-white hover:bg-transparent hover:text-indigo-600 focus:outline-none focus:ring active:text-indigo-500'
    end 

    def format_date(date)
        date.strftime('%F')
      end

    def btn_class_xs
        'inline-block rounded border border-red-600 px-1 py-1 text-xs font-medium text-red-600 hover:bg-red-600 hover:text-white focus:outline-none focus:ring active:bg-red-500'

    end

end
