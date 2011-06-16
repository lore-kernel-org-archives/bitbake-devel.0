Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jpuhlman@mvista.com>) id 1QXCM8-0004iL-TF
	for bitbake-devel@lists.openembedded.org;
	Thu, 16 Jun 2011 15:11:33 +0200
Received: by pwj9 with SMTP id 9so650121pwj.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jun 2011 06:08:03 -0700 (PDT)
Received: by 10.68.32.72 with SMTP id g8mr426021pbi.184.1308229683765;
	Thu, 16 Jun 2011 06:08:03 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-204-11.hsd1.ca.comcast.net
	[67.187.204.11])
	by mx.google.com with ESMTPS id w2sm908476pbg.37.2011.06.16.06.08.02
	(version=TLSv1/SSLv3 cipher=OTHER);
	Thu, 16 Jun 2011 06:08:03 -0700 (PDT)
Message-ID: <4DFA002F.5070709@mvista.com>
Date: Thu, 16 Jun 2011 06:07:59 -0700
From: Jeremy Puhlman <jpuhlman@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US;
	rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
	ThunderBrowse/3.3.5
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
X-Enigmail-Version: 1.1.1
Subject: None server + knotty + -D missing running task output?
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
X-List-Received-Date: Thu, 16 Jun 2011 13:11:33 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Kicking stuff around a little, I took the head bitbake and swapped it
over to using the none server. Running with the default ui(knotty) and
passing -D, I seem to be missing the log data that normally gets output
when you pass -D. Swapping back to the process server, and the output
comes back. All the data is still safely stowed in the log.do_* files,
but I was wondering if this was a bug or expected behavior out of the
"none" server?

-- 
Jeremy Puhlman
Montavista Sofware, LLC.


