Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1SfBfO-0000aA-LV
	for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2012 17:08:58 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q5EEwKea023616
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Jun 2012 07:58:20 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Thu, 14 Jun 2012 07:58:20 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Jun 2012 09:58:17 -0500
Message-ID: <1339685898-24757-1-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
MIME-Version: 1.0
Subject: [PATCH 0/1] process.py, build.py: Fix log truncation problems with flush()
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
X-List-Received-Date: Thu, 14 Jun 2012 15:08:59 -0000
Content-Type: text/plain

Separately Richard had asked me if this proposed patch to flush things
out to disk immediately had a negative performance impact.  It is
actually the opposite effect due to a very subtle problem that was
fixed.

My litmus test is to wipe the .o files, drop kernel caches, force
compile the kernel which will generate 100's of very small single line
logs under the size of the buffer limit.

Without the log flushing patch compiling a kernel:
   real    3m33.906s
   user    0m53.523s
   sys     0m24.518s

With the log flushing patch compiling a kernel:
   real    3m28.102s
   user    0m53.251s
   sys     0m24.982s

Why is it faster you ask?

It has to do with the alternating blocking reads on stdin and stderr.
First the existing code blocks on stdout until the buffer fills up in
the python logger.  Once the buffer is full, it will switch to
blocking on stderr, and if nothing ever comes it may wait all the way
until the task completes and then tries to chunk the buffer out to disk
at the end which is quite wasteful.  

Sometimes the existing behavior also leads to having any bitbake
injected error messages into the log file appear out of chronological
order with respect to how ever much data was in the log because bitbake
will emit the error to stderr and stderr could get flushed before
stdout.

Cheers,
Jason.


