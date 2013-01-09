Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1Tt23O-0006mQ-9g
	for bitbake-devel@lists.openembedded.org;
	Wed, 09 Jan 2013 21:15:14 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r09ISZPL029526
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 9 Jan 2013 10:28:37 -0800 (PST)
Received: from e6410-2 (172.25.40.227) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.318.4;
	Wed, 9 Jan 2013 10:28:34 -0800
Date: Wed, 9 Jan 2013 12:27:57 -0600
From: Peter Seebach <peter.seebach@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Message-ID: <20130109122757.5c134665@e6410-2>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Subject: Variable tracking...
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
X-List-Received-Date: Wed, 09 Jan 2013 20:15:18 -0000
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

So, I sent some variable-tracking patches a while back that had been
cleaned up in response to various feedback. And I don't think I heard
back anything about problems with them, but I don't think I heard
anything positive.

Is anyone still interested in the variable-assignment-tracking stuff,
other than me? I maintain that it is REALLY useful when trying to track
down variables getting the wrong values.

-s
-- 
Listen, get this.  Nobody with a good compiler needs to be justified.


