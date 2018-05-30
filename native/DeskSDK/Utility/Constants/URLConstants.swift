//
//  URLConstants.swift
//  Pods
//
//  Created by rajeshkumar.l on 17/10/17.
//
//

import Foundation

internal struct URLPathConstants {

    //Organizations Provoider
    static let allOrganizations           = "organizations"

    //Ticker Provoider
    static let getATicket                 = "tickets/%@"
    static let listAllTickets             = "tickets"
    static let createTicket               = "tickets"
    static let updateTicket               = "tickets/%@"//{ticket_id}
    static let mergeTicket                = "tickets/%@/merge"//{ticket_id}
    static let moveTicket                 = "tickets/%@/move"//{ticket_id}
    static let splitTicket                = "tickets/%@/thread/%@/split"//{ticket_id}{thread_id}
    static let updateManyTicket           = "tickets/updateMany"
    static let ticketMarkASSPAM           = "tickets/markSpam"

    //Thread Provoider
    static let getAThread                 = "tickets/%@/threads/%@"// {ticket_id}, {thread_id}
    static let listAllThreads             = "tickets/%@/threads"// {ticket_id}
    static let sendReply                  = "tickets/%@/sendReply"// {ticket_id}
    static let draftEmail                 = "tickets/%@/draftReply"// {ticket_id}
    static let updateDraft                = "tickets/%@/draftReply/%@"// {ticket_id}, {thread_id}
    static let deleteThreadAttachement    = "tickets/$@/threads/%@/attachments/%@"//{ticket_id}, {thread_id}, {attachment_id}
    static let listAllConversation        = "tickets/%@/conversations"// {ticket_id}

    //TicketComment Provoider
    static let createTicketComment        = "tickets/%@/comments"
    static let updateTicketComment        = "tickets/%@/comments/%@"
    static let deleteTicketComment        = "tickets/%@/comments/%@"
    static let getTicketComment           = "tickets/%@/comments/%@"
    static let getAllTicketComment        = "tickets/%@/comments"

    //TicketAttachments
    static let listAllTicketAttchements   = "tickets/%@/attachments"//{Ticket ID}
    static let createTicketAttachment     = "tickets/%@/attachments"// {ticket_id}
    static let updateTicketAttachment     = "tickets/%@/attachments/%@"//{ticket_id], {attachment_id}
    static let deleteTicketAttachment     = "tickets/%@/attachments/%@"//{ticket_id], {attachment_id}

    //TicketTimeEntry
    static let listAllTicketTimeEntry     = "tickets/%@/timeEntry"//{ticket_id}
    static let getTicketTimeEntry         = "tickets/%@/timeEntry/%@"//{ticket_id}{timeEntry_id}
    static let addTicketTimeEntry         = "tickets/%@/timeEntry"//{ticket_id}
    static let updateTicketTimeEntry      = "tickets/%@/timeEntry/%@"//{ticket_id}{timeEntry_id}
    static let deleteTicketTimeEntry      = "tickets/%@/timeEntry/%@"//{ticket_id}{timeEntry_id}

    //ContactProviders
    static let listAllContact             = "contacts"
    static let getAContact                = "contacts/%@"//{Contact ID}
    static let createContact              = "contacts"
    static let updateContact              = "contacts/%@"//{Contact ID}
    static let getTicketsByContact        = "contacts/%@/tickets"//{Contact ID}


    //ContactsAttachments
    static let listAllContactAttchements  = "contacts/%@/attachments"//{contact ID}
    static let createContactAttachment    = "contacts/%@/attachments"// {contact ID}
    static let deleteContactAttachment    = "contacts/%@/attachments/%@"//{contact ID}, {attachment_id}

    //Accounts
    static let listAllAccounts            = "accounts"
    static let getAAccounts               = "accounts/%@"//{accounts ID}
    static let createAccounts             = "accounts"
    static let updateAccounts             = "accounts/%@"//{accounts ID}
    static let getTicketsByAccount        = "accounts/%@/tickets"//{account ID}


    //Accounts Attachments
    static let listAllAccountsAttchements = "accounts/%@/attachments"//{Accounts ID}
    static let createAccountsAttachment   = "accounts/%@/attachments"// {Accounts ID}
    static let deleteAccountsAttachment   = "accounts/%@/attachments/%@"//{Accounts ID}, {attachment_id}

    //Task
    static let listAllTask                = "tasks"
    static let getATask                   = "tasks/%@"//{tasks ID}
    static let createTask                 = "tasks"
    static let updateTask                 = "tasks/%@"//{tasks ID}
    static let listTaskByTicket           = "tickets/%@/tasks"//{Ticket ID}

    //Task Attachments
    static let listAllTaskAttchements     = "tasks/%@/attachments"//{Task ID}
    static let createTaskAttachment       = "tasks/%@/attachments"// {Task ID}
    static let deleteTaskAttachment       = "tasks/%@/attachments/%@"//{Task ID}, {attachment_id}

    //Agents
    static let listAllAgent               = "agents"
    static let getAAgent                  = "agents/%@"//{Agent ID}

    //Departments
    static let listAllDepartments         = "departments"
    static let getADepartment             = "departments/%@"//{departments ID}

    //Uploads
    static let uploads                    = "uploads"

    //Contracts
    static let  getAContracts             = "contracts/%@"//{{contract_id}}
    static let  listAllContracts          = "contracts"

    //Search
    static let searchAcrossEntities       = "search"
    static let  searchTicket              = "tickets/search"
    static let  searchAccount             = "accounts/search"
    static let  searchContact             = "contacts/search"
    static let  searchTask                = "tasks/search"
    
    //MailReplyAddress
    static let  mailReplyAddress          = "mailReplyAddress"
    
    //Views
    static let listTicketViews                = "ticketsviews"
 
}


