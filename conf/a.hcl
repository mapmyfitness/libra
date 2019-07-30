// Nomad Client configuration
nomad {
  address = "http://10.1.1.123:4646"
}

# backend "cloudwatch" {
#   kind     = "cloudwatch"
#   region   = "us-east-1"
# }

backend "influxtest" {
  kind = "influxdb"
  addr = "http://influxdb.yotpo.com:8086"
  useragent = "libra"
}

job "api-resque-account" {
  group "account" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "Account"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "Account"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-accountemail" {
  group "accountemail" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AccountEmail"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AccountEmail"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-accountplatform" {
  group "accountplatform" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AccountPlatform"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AccountPlatform"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-accountplatformcredentialsupdater" {
  group "accountplatformcredentialsupdater" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AccountPlatformCredentialsUpdater"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AccountPlatformCredentialsUpdater"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-accountplatformshopdetailsupdaterjobs" {
  group "accountplatformshopdetailsupdaterjobs" {
    min_count = 0
    max_count = 1

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AccountPlatformShopDetailsUpdaterJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AccountPlatformShopDetailsUpdaterJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-accountreviewsscorescalculator" {
  group "accountreviewsscorescalculator" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AccountReviewsScoresCalculator"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AccountReviewsScoresCalculator"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-accountscoreupdater" {
  group "accountscoreupdater" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AccountScoreUpdater"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AccountScoreUpdater"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-accountserviceprovider" {
  group "accountserviceprovider" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AccountServiceProvider"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AccountServiceProvider"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-adminactions" {
  group "adminactions" {
    min_count = 0
    max_count = 4

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AdminActions"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AdminActions"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-affiliationmethod" {
  group "affiliationmethod" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AffiliationMethod"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AffiliationMethod"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-afterinvoicesitereviewrequestschedulerjobs" {
  group "afterinvoicesitereviewrequestschedulerjobs" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AfterInvoiceSiteReviewRequestSchedulerJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AfterInvoiceSiteReviewRequestSchedulerJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-afterinvoicesitereviewrequestsenderjobs" {
  group "afterinvoicesitereviewrequestsenderjobs" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AfterInvoiceSiteReviewRequestSenderJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AfterInvoiceSiteReviewRequestSenderJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-afterservicesitereviewrequestschedulerjobs" {
  group "afterservicesitereviewrequestschedulerjobs" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AfterServiceSiteReviewRequestSchedulerJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AfterServiceSiteReviewRequestSchedulerJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-afterservicesitereviewrequestsenderjobs" {
  group "afterservicesitereviewrequestsenderjobs" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AfterServiceSiteReviewRequestSenderJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AfterServiceSiteReviewRequestSenderJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-aftersignupevents" {
  group "aftersignupevents" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AfterSignupEvents"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AfterSignupEvents"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-albumsmigrator" {
  group "albumsmigrator" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AlbumsMigrator"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AlbumsMigrator"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-analyticscalculator" {
  group "analyticscalculator" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AnalyticsCalculator"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AnalyticsCalculator"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-answernotificationquestionersenderjobs" {
  group "answernotificationquestionersenderjobs" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AnswerNotificationQuestionerSenderJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AnswerNotificationQuestionerSenderJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-answerrequestpastshopperssenderjobs" {
  group "answerrequestpastshopperssenderjobs" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AnswerRequestPastShoppersSenderJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AnswerRequestPastShoppersSenderJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-answersyndicator" {
  group "answersyndicator" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AnswerSyndicator"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AnswerSyndicator"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-archivechangelogic" {
  group "archivechangelogic" {
    min_count = 0
    max_count = 1

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ArchiveChangeLogic"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ArchiveChangeLogic"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-asyncmailer" {
  group "asyncmailer" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AsyncMailer"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "AsyncMailer"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-bigcommerceordercommandshandler" {
  group "bigcommerceordercommandshandler" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "BigcommerceOrderCommandsHandler"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "BigcommerceOrderCommandsHandler"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-bigcommerceproductcommandshandler" {
  group "bigcommerceproductcommandshandler" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "BigcommerceProductCommandsHandler"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "BigcommerceProductCommandsHandler"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-churnalert" {
  group "churnalert" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ChurnAlert"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ChurnAlert"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-commentqueue" {
  group "commentqueue" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "CommentQueue"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "CommentQueue"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-commentsyndicator" {
  group "commentsyndicator" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "CommentSyndicator"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "CommentSyndicator"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-couponnotificationsenderjobs" {
  group "couponnotificationsenderjobs" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "CouponNotificationSenderJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "CouponNotificationSenderJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-createpurchases" {
  group "createpurchases" {
    min_count = 0
    max_count = 12

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "CreatePurchases"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "CreatePurchases"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-crosssitepromotedproduct" {
  group "crosssitepromotedproduct" {
    min_count = 0
    max_count = 1

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "CrossSitePromotedProduct"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "CrossSitePromotedProduct"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-currencyrates" {
  group "currencyrates" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "CurrencyRates"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "CurrencyRates"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-demomailsenderjobs" {
  group "demomailsenderjobs" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "DemoMailSenderJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "DemoMailSenderJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-elasticsearchcreate" {
  group "elasticsearchcreate" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ElasticSearchCreate"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ElasticSearchCreate"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-elasticsearchdelete" {
  group "elasticsearchdelete" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ElasticSearchDelete"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ElasticSearchDelete"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-elasticsearchproductsappsbulkupdate" {
  group "elasticsearchproductsappsbulkupdate" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ElasticSearchProductsAppsBulkUpdate"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ElasticSearchProductsAppsBulkUpdate"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-elasticsearchreviewcreate" {
  group "elasticsearchreviewcreate" {
    min_count = 0
    max_count = 1

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ElasticSearchReviewCreate"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ElasticSearchReviewCreate"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-elasticsearchreviewerscreate" {
  group "elasticsearchreviewerscreate" {
    min_count = 0
    max_count = 1

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ElasticSearchReviewersCreate"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ElasticSearchReviewersCreate"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-elasticsearchreviewersupdate" {
  group "elasticsearchreviewersupdate" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ElasticSearchReviewersUpdate"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ElasticSearchReviewersUpdate"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-elasticsearchsynchelper" {
  group "elasticsearchsynchelper" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ElasticSearchSyncHelper"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ElasticSearchSyncHelper"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-elasticsearchupdate" {
  group "elasticsearchupdate" {
    min_count = 0
    max_count = 10

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ElasticSearchUpdate"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ElasticSearchUpdate"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-elasticsearchusersemailcontrolsbulkupdate" {
  group "elasticsearchusersemailcontrolsbulkupdate" {
    min_count = 0
    max_count = 1

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ElasticSearchUsersEmailControlsBulkUpdate"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ElasticSearchUsersEmailControlsBulkUpdate"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-elasticsearchusersemailcontrolscreate" {
  group "elasticsearchusersemailcontrolscreate" {
    min_count = 0
    max_count = 1

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ElasticSearchUsersEmailControlsCreate"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ElasticSearchUsersEmailControlsCreate"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-elasticsearchusersemailcontrolsupdate" {
  group "elasticsearchusersemailcontrolsupdate" {
    min_count = 0
    max_count = 1

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ElasticSearchUsersEmailControlsUpdate"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ElasticSearchUsersEmailControlsUpdate"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-emailmissedproducts" {
  group "emailmissedproducts" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "EmailMissedProducts"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "EmailMissedProducts"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-eventbus" {
  group "eventbus" {
    min_count = 0
    max_count = 5

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "Eventbus"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "Eventbus"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-exacttargetasynctask" {
  group "exacttargetasynctask" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ExactTargetAsyncTask"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ExactTargetAsyncTask"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-exceptionlogstashreporter" {
  group "exceptionlogstashreporter" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ExceptionLogstashReporter"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ExceptionLogstashReporter"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-exportreviewsjobs" {
  group "exportreviewsjobs" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ExportReviewsJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ExportReviewsJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-facebookads" {
  group "facebookads" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "FacebookAds"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "FacebookAds"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-featureactionasync" {
  group "featureactionasync" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "FeatureActionAsync"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "FeatureActionAsync"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-featurecallbacks" {
  group "featurecallbacks" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "FeatureCallbacks"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "FeatureCallbacks"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-featuresettingsasynccachecleaner" {
  group "featuresettingsasynccachecleaner" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "FeatureSettingsAsyncCacheCleaner"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "FeatureSettingsAsyncCacheCleaner"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-feeds" {
  group "feeds" {
    min_count = 0
    max_count = 1

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "Feeds"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "Feeds"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-fixproductappreviewsscoresjobs" {
  group "fixproductappreviewsscoresjobs" {
    min_count = 0
    max_count = 1

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "FixProductAppReviewsScoresJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "FixProductAppReviewsScoresJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-fragmentcleanerjobs" {
  group "fragmentcleanerjobs" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "FragmentCleanerJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "FragmentCleanerJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-googleanalytics" {
  group "googleanalytics" {
    min_count = 0
    max_count = 1

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "GoogleAnalytics"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "GoogleAnalytics"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-googlefeed" {
  group "googlefeed" {
    min_count = 0
    max_count = 5

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "GoogleFeed"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "GoogleFeed"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-googlefeedactionsjobs" {
  group "googlefeedactionsjobs" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "GoogleFeedActionsJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "GoogleFeedActionsJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-hubspot" {
  group "hubspot" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "Hubspot"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "Hubspot"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-imagewidgetcachecleaner" {
  group "imagewidgetcachecleaner" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ImageWidgetCacheCleaner"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ImageWidgetCacheCleaner"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-imagessyndicator" {
  group "imagessyndicator" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ImagesSyndicator"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ImagesSyndicator"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-inboundemailactions" {
  group "inboundemailactions" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "InboundEmailActions"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "InboundEmailActions"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-integrations" {
  group "integrations" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "Integrations"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "Integrations"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-linkvisits" {
  group "linkvisits" {
    min_count = 0
    max_count = 10

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "LinkVisits"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "LinkVisits"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-livemoderationdeletereview" {
  group "livemoderationdeletereview" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "LiveModerationDeleteReview"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "LiveModerationDeleteReview"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-livemoderationupdatereview" {
  group "livemoderationupdatereview" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "LiveModerationUpdateReview"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "LiveModerationUpdateReview"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-mailafterpurchasepreparer" {
  group "mailafterpurchasepreparer" {
    min_count = 0
    max_count = 5

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "MailAfterPurchasePreparer"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "MailAfterPurchasePreparer"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-maphtmleditorreviewrequestsenderjobs" {
  group "maphtmleditorreviewrequestsenderjobs" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "MapHtmlEditorReviewRequestSenderJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "MapHtmlEditorReviewRequestSenderJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-minisitestateupdater" {
  group "minisitestateupdater" {
    min_count = 0
    max_count = 1

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "MinisiteStateUpdater"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "MinisiteStateUpdater"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-moderationfeed" {
  group "moderationfeed" {
    min_count = 0
    max_count = 1

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ModerationFeed"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ModerationFeed"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-moderationtokencleaner" {
  group "moderationtokencleaner" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ModerationTokenCleaner"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ModerationTokenCleaner"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-newreviewhandlerjobs" {
  group "newreviewhandlerjobs" {
    min_count = 0
    max_count = 5

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "NewReviewHandlerJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "NewReviewHandlerJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-oauthtoken" {
  group "oauthtoken" {
    min_count = 0
    max_count = 3

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "OauthToken"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "OauthToken"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-orderdatascreate" {
  group "orderdatascreate" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "OrderDatasCreate"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "OrderDatasCreate"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-orderlimitstatsincrementjobs" {
  group "orderlimitstatsincrementjobs" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "OrderLimitStatsIncrementJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "OrderLimitStatsIncrementJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-orderlimitstatsresetjobs" {
  group "orderlimitstatsresetjobs" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "OrderLimitStatsResetJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "OrderLimitStatsResetJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-orderproductreviewrequestsenderjobs" {
  group "orderproductreviewrequestsenderjobs" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "OrderProductReviewRequestSenderJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "OrderProductReviewRequestSenderJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-orderproductsappinvalidationcheckerjobs" {
  group "orderproductsappinvalidationcheckerjobs" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "OrderProductsAppInvalidationCheckerJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "OrderProductsAppInvalidationCheckerJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-orderproductsappsinvalidatorjobs" {
  group "orderproductsappsinvalidatorjobs" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "OrderProductsAppsInvalidatorJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "OrderProductsAppsInvalidatorJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-ordersitereviewrequestsenderjobs" {
  group "ordersitereviewrequestsenderjobs" {
    min_count = 0
    max_count = 5

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "OrderSiteReviewRequestSenderJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "OrderSiteReviewRequestSenderJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-orders" {
  group "orders" {
    min_count = 0
    max_count = 1

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "Orders"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "Orders"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-orderscharge" {
  group "orderscharge" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "OrdersCharge"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "OrdersCharge"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-ordersimportjobs" {
  group "ordersimportjobs" {
    min_count = 0
    max_count = 1

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "OrdersImportJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "OrdersImportJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-packageupdater" {
  group "packageupdater" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "PackageUpdater"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "PackageUpdater"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-productappreviewsscore" {
  group "productappreviewsscore" {
    min_count = 0
    max_count = 1

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ProductAppReviewsScore"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ProductAppReviewsScore"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-productimagesaver" {
  group "productimagesaver" {
    min_count = 0
    max_count = 5

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ProductImageSaver"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ProductImageSaver"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-productreviewrequestsenderjobs" {
  group "productreviewrequestsenderjobs" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ProductReviewRequestSenderJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ProductReviewRequestSenderJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-producturlvalidator" {
  group "producturlvalidator" {
    min_count = 0
    max_count = 3

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ProductUrlValidator"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ProductUrlValidator"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-productsappscatalogjobs" {
  group "productsappscatalogjobs" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ProductsAppsCatalogJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ProductsAppsCatalogJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-productsappscreator" {
  group "productsappscreator" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ProductsAppsCreator"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ProductsAppsCreator"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-productsappsvalidurlsetter" {
  group "productsappsvalidurlsetter" {
    min_count = 0
    max_count = 1

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ProductsAppsValidUrlSetter"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ProductsAppsValidUrlSetter"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-productsgroupingjobs" {
  group "productsgroupingjobs" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ProductsGroupingJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ProductsGroupingJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-productsgroupingmaintenancejobs" {
  group "productsgroupingmaintenancejobs" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ProductsGroupingMaintenanceJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ProductsGroupingMaintenanceJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-productsgroupingsyncjobs" {
  group "productsgroupingsyncjobs" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ProductsGroupingSyncJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ProductsGroupingSyncJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-productsimportjobs" {
  group "productsimportjobs" {
    min_count = 0
    max_count = 1

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ProductsImportJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ProductsImportJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-purchasemigrate" {
  group "purchasemigrate" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "PurchaseMigrate"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "PurchaseMigrate"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-purchasepuller" {
  group "purchasepuller" {
    min_count = 0
    max_count = 1

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "PurchasePuller"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "PurchasePuller"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-purchasereceiver" {
  group "purchasereceiver" {
    min_count = 0
    max_count = 10

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "PurchaseReceiver"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "PurchaseReceiver"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-purchasesevent" {
  group "purchasesevent" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "PurchasesEvent"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "PurchasesEvent"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-qandaretarget" {
  group "qandaretarget" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "QAndARetarget"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "QAndARetarget"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-questionaction" {
  group "questionaction" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "QuestionAction"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "QuestionAction"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-questionconfirmationsenderjobs" {
  group "questionconfirmationsenderjobs" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "QuestionConfirmationSenderJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "QuestionConfirmationSenderJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-questionshandler" {
  group "questionshandler" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "QuestionsHandler"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "QuestionsHandler"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-questionssyndicationmanager" {
  group "questionssyndicationmanager" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "QuestionsSyndicationManager"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "QuestionsSyndicationManager"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-recordsdeletiontracker" {
  group "recordsdeletiontracker" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "RecordsDeletionTracker"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "RecordsDeletionTracker"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-resendproductreviewrequestsenderjobs" {
  group "resendproductreviewrequestsenderjobs" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ResendProductReviewRequestSenderJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ResendProductReviewRequestSenderJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-reviewaction" {
  group "reviewaction" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ReviewAction"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ReviewAction"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-reviewcommentnotificationsenderjobs" {
  group "reviewcommentnotificationsenderjobs" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ReviewCommentNotificationSenderJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ReviewCommentNotificationSenderJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-reviewcontentdelete" {
  group "reviewcontentdelete" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ReviewContentDelete"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ReviewContentDelete"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-reviewcreate" {
  group "reviewcreate" {
    min_count = 0
    max_count = 5

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ReviewCreate"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ReviewCreate"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-reviewdelete" {
  group "reviewdelete" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ReviewDelete"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ReviewDelete"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-reviewimagesaver" {
  group "reviewimagesaver" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ReviewImageSaver"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ReviewImageSaver"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-reviewmetadatacreate" {
  group "reviewmetadatacreate" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ReviewMetaDataCreate"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ReviewMetaDataCreate"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-reviewmoderatorjobs" {
  group "reviewmoderatorjobs" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ReviewModeratorJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ReviewModeratorJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-reviewrequestcharge" {
  group "reviewrequestcharge" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ReviewRequestCharge"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ReviewRequestCharge"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-reviewsproductsfixer" {
  group "reviewsproductsfixer" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ReviewsProductsFixer"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ReviewsProductsFixer"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-richsnippetupdater" {
  group "richsnippetupdater" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "RichSnippetUpdater"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "RichSnippetUpdater"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-saveemailusercontrolids" {
  group "saveemailusercontrolids" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "SaveEmailUserControlIds"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "SaveEmailUserControlIds"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-sentimentemailfallback" {
  group "sentimentemailfallback" {
    min_count = 0
    max_count = 1

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "SentimentEmailFallback"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "SentimentEmailFallback"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-sentimentupdatejobs" {
  group "sentimentupdatejobs" {
    min_count = 0
    max_count = 5

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "SentimentUpdateJobs"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "SentimentUpdateJobs"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-serviceprovideremailpuller" {
  group "serviceprovideremailpuller" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ServiceProviderEmailPuller"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ServiceProviderEmailPuller"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-shopifybulkorderdatascreate" {
  group "shopifybulkorderdatascreate" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ShopifyBulkOrderDatasCreate"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ShopifyBulkOrderDatasCreate"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-shopifyordercommandshandler" {
  group "shopifyordercommandshandler" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ShopifyOrderCommandsHandler"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ShopifyOrderCommandsHandler"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-shopifywebhookhandler" {
  group "shopifywebhookhandler" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ShopifyWebhookHandler"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ShopifyWebhookHandler"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-socialprocessor" {
  group "socialprocessor" {
    min_count = 0
    max_count = 5

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "SocialProcessor"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "SocialProcessor"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-socialpush" {
  group "socialpush" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "SocialPush"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "SocialPush"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-statisticscache" {
  group "statisticscache" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "StatisticsCache"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "StatisticsCache"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-subsriptionhandler" {
  group "subsriptionhandler" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "SubsriptionHandler"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "SubsriptionHandler"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-summaryreport" {
  group "summaryreport" {
    min_count = 0
    max_count = 1

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "SummaryReport"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "SummaryReport"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-summaryreporttasks" {
  group "summaryreporttasks" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "SummaryReportTasks"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "SummaryReportTasks"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-syndicationmanager" {
  group "syndicationmanager" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "SyndicationManager"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "SyndicationManager"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-syndicationpair" {
  group "syndicationpair" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "SyndicationPair"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "SyndicationPair"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-tableoptimizerjob" {
  group "tableoptimizerjob" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "TableOptimizerJob"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "TableOptimizerJob"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-tokenhandler" {
  group "tokenhandler" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "TokenHandler"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "TokenHandler"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-trackconversion" {
  group "trackconversion" {
    min_count = 0
    max_count = 10

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "TrackConversion"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "TrackConversion"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-uniquecouponcode" {
  group "uniquecouponcode" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "UniqueCouponCode"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "UniqueCouponCode"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-unsubscribe" {
  group "unsubscribe" {
    min_count = 0
    max_count = 1

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "Unsubscribe"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "Unsubscribe"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-updatecampaignmonitor" {
  group "updatecampaignmonitor" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "UpdateCampaignMonitor"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "UpdateCampaignMonitor"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-updatesalesforce" {
  group "updatesalesforce" {
    min_count = 0
    max_count = 1

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "UpdateSalesForce"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "UpdateSalesForce"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-updatestatistics" {
  group "updatestatistics" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "UpdateStatistics"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "UpdateStatistics"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-useremailreports" {
  group "useremailreports" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "UserEmailReports"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "UserEmailReports"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-useremails" {
  group "useremails" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "UserEmails"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "UserEmails"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-volusionddos" {
  group "volusionddos" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "VolusionDdos"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "VolusionDdos"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-yotpoactions" {
  group "yotpoactions" {
    min_count = 0
    max_count = 3

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "YotpoActions"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "YotpoActions"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-zendeskupdater" {
  group "zendeskupdater" {
    min_count = 0
    max_count = 2

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ZendeskUpdater"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "ZendeskUpdater"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}

job "api-resque-installedstatecalculation" {
  group "installedstatecalculation" {
    min_count = 0
    max_count = 1

    rule "increase worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "installedStateCalculation"
      }
      time_period = "60s"
      comparison = "above_or_equal"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "increase_count"
      action_value = 1
    }

    rule "decrease worker count" {
      backend = "influxtest"
      database_name = "yotpo_api_production"
      measurement_name = "resque_backlog"
      selector = "last"
      field = "backlog"
      where_clause = {
       "queue" = "installedStateCalculation"
      }
      time_period = "60s"
      comparison = "below"
      comparison_value = 1.0
      cron = "*/30 * * * * *"
      action       = "decrease_count"
      action_value = 1
    }
  }
}