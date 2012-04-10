Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1SHWWK-0002gw-2i
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Apr 2012 10:33:48 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q3A8OTCn017264
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Apr 2012 01:24:29 -0700 (PDT)
Received: from [128.224.162.196] (128.224.162.196) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Tue, 10 Apr 2012 01:24:29 -0700
Message-ID: <4F83EE3C.8040904@windriver.com>
Date: Tue, 10 Apr 2012 16:24:28 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:11.0) Gecko/20120310 Thunderbird/11.0
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
Subject: questions about bitbake world
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
X-List-Received-Date: Tue, 10 Apr 2012 08:33:48 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit


Hello experts,

In the following code:

def buildWorldTargetList(self):
...
         for f in self.status.possible_world:
             terminal = True
             pn = self.status.pkg_fn[f]

             for p in pn_provides[pn]:
                 if p.startswith('virtual/'):
                     parselog.debug(2, "World build skipping %s due to %s 
provider starting with virtual/", f, p)
                     terminal = False
                     break
...

Does it mean that if a recipe contains:

PROVIDES = "virtual/something"

Then it would not be built until a pkg depends on it? Why we design it in this
way, please?

-- 
Thanks

Robert


