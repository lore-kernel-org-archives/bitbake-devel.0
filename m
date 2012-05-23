Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1SX0l2-0000qZ-PJ
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 03:53:01 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q4N1goI3009049
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 May 2012 18:42:50 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.61) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0;
	Tue, 22 May 2012 18:42:49 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 22 May 2012 20:46:29 -0500
Message-ID: <cover.1337714416.git.mark.hatle@windriver.com>
X-Mailer: git-send-email 1.7.3.4
MIME-Version: 1.0
X-Originating-IP: [172.25.34.61]
Subject: [PATCH 0/3] RFC: Refactor/cleanup logging/run file generation
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 23 May 2012 01:53:01 -0000
Content-Type: text/plain

(this is a resend as it appears only 1/3 of showed up..)

The following series is an attempt at changing the way the task logging 
is performed and adding additional information to help someone determine 
what has gone wrong.

This is an initial requestion for comments, I'm not sure what is 
implemented currently is right yet.

Additional debug information is sent on function execution and 
termination.  This will help someone determine the order of function 
execution within a task.

There is also a new log.task_order file that explains the order the 
tasks have been run.  The log includes a reference the associated log 
file for that particular task.

This also introduces a way to change the format of the log and run
filenames.  I've been testing with both the default and variations.. my
current perferred format is:

BB_LOGFMT = "{task}/log.{task}.{pid}"
BB_RUNFMT = "{task}/run.{taskfunc}.{pid}"

another useful one is:

BB_LOGFMT = "log.{task}.{pid}"
BB_RUNFMT = "run.{taskfunc}.{pid}"




