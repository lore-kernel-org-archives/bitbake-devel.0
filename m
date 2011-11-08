Received: from mga06.intel.com ([134.134.136.21] helo=orsmga101.jf.intel.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <scott.a.garman@intel.com>) id 1RNuAz-0003lZ-W5
	for bitbake-devel@lists.openembedded.org;
	Tue, 08 Nov 2011 23:29:54 +0100
Received: from mail-pz0-f44.google.com ([209.85.210.44])
	by mga02.intel.com with ESMTP/TLS/RC4-SHA; 08 Nov 2011 14:22:28 -0800
Received: by pzk32 with SMTP id 32so4627010pzk.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 08 Nov 2011 14:22:28 -0800 (PST)
Received: by 10.68.25.170 with SMTP id d10mr201315pbg.7.1320790948469;
	Tue, 08 Nov 2011 14:22:28 -0800 (PST)
Received: from [192.168.1.12] (c-98-246-160-155.hsd1.or.comcast.net.
	[98.246.160.155])
	by mx.google.com with ESMTPS id jm5sm7532197pbc.1.2011.11.08.14.22.26
	(version=SSLv3 cipher=OTHER); Tue, 08 Nov 2011 14:22:27 -0800 (PST)
Message-ID: <4EB9ABAE.4040600@intel.com>
Date: Tue, 08 Nov 2011 14:22:38 -0800
From: Scott Garman <scott.a.garman@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <1320775335.10843.104.camel@ted>
In-Reply-To: <1320775335.10843.104.camel@ted>
Subject: Re: [PATCH RFC] data_smart: Add appendVar/prependVar functions
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
X-List-Received-Date: Tue, 08 Nov 2011 22:29:54 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 11/08/2011 10:02 AM, Richard Purdie wrote:
> This patch adds appendVar and prependVar functions to the data store
> meaning python code would no longer have to do the getVar, append and
> the setVar dance that much of the current python code does.

So useful! Thanks for this.

Scott

-- 
Scott Garman
Embedded Linux Engineer - Yocto Project
Intel Open Source Technology Center


