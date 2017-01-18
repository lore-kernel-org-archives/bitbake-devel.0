Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 002C071A21
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Jan 2017 19:02:16 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v0IJ2G3O028856
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Jan 2017 11:02:16 -0800 (PST)
Received: from soho-mhatle-m.local (172.25.36.235) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Wed, 18 Jan 2017 11:02:16 -0800
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <f8610648-ea83-06ab-01fa-f8260597973c@windriver.com>
Date: Wed, 18 Jan 2017 13:02:15 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
	Gecko/20100101 Thunderbird/45.6.0
MIME-Version: 1.0
Subject: Filename too long
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 18 Jan 2017 19:02:17 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

I found a problem today working through a problem report.

We have a situation where we automatically add certain project directories as
premirrors within the environment.

During the fetch2 work, the system takes this long pathname, and then embeds it
into ud.lockfile parameter, we end up with something like:

The path to the build/download dir is about 250 characters... (abbreviated below)

ud.lockfile =
/my/really/log/path/to/my/project/build/download/git2/file....my.really.log.path.to.my.project.layers.wr-kernel.recipes-kernel.linux.......git.kernel-4.8.x.git.lock

This triggers an exception, IOError with the errno '36', and error string of
'File name too long'.  (Note, this is the filename, NOT the path being too long!)

In the bitbake/lib/bb/utils.py: def lockfile(name, shared=False, retry=True,
block=False)

The system tries to:

while True:
    try:
        lf = open(name, 'a+')
        ... more work here ...
    except Exception:
        ... close the file, if opened ...
        pass
    if not retry:
        return None

This triggers an endless loop if this happens.

So at a minimum we probably need to extend the exception handling to look for
file (or path) too long errors and return/stop.

I'm wondering if, something like the following should be added:

 exception IOError as e:
     errno, strerror = e.args
     logger.fatal("IOError on lock: [%s] %s" % (errno, strerror))
     try:
         lf.close()
     except Exception:
         pass
     retry = False
     pass

(Is stopping on all IOErrors too broad of a check?)


Second, I'm not sure where the lockfile name is determined, but should there be
a way in there to shorten the lockfile to say the 'basename' instead of a full
path (if specified)?

Any suggestions would be appreciated.

--Mark

