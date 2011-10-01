Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dbaryshkov@gmail.com>)
	id 1RA3xR-0006Bw-80; Sat, 01 Oct 2011 20:06:41 +0200
Received: by iadx2 with SMTP id x2so3287754iad.6
	for <multiple recipients>; Sat, 01 Oct 2011 11:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=EBTWn2CNZaZIjg+hgF7xnSDKWV/jJfq/p1/clUa1+gU=;
	b=UHVKYasgZeITirUfVBmySOW92iIN6FQfXUFcnm5oIMG24Vz4lIsszEUSZKQRPDE7nm
	U291BcNz8t9I9BSUogt1gIxiOSPljCOzxqEtuBzuhvD5tkGL4KFhGOapwd3NOqA8Gspp
	P+p6kt2Kvxz1q77FuJwTjMSk+JbOvO1RQ+mhg=
Received: by 10.68.42.6 with SMTP id j6mr62543629pbl.41.1317492069597;
	Sat, 01 Oct 2011 11:01:09 -0700 (PDT)
Received: from [137.202.140.192] (nat-rup.mentorg.com. [139.181.168.34])
	by mx.google.com with ESMTPS id d1sm11081821pbm.3.2011.10.01.11.01.07
	(version=SSLv3 cipher=OTHER); Sat, 01 Oct 2011 11:01:08 -0700 (PDT)
Message-ID: <4E875521.3000809@gmail.com>
Date: Sat, 01 Oct 2011 22:00:01 +0400
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US;
	rv:1.9.2.21) Gecko/20110831 Iceowl/1.0b2 Icedove/3.1.13
MIME-Version: 1.0
To: Paul Eggleton <paul.eggleton@linux.intel.com>
References: <CALT56yN5hXMLBhHVLKyHbNb=7WDb3pZUB0Q+HNKc-2t+g6M58A@mail.gmail.com>
	<201109281116.00890.paul.eggleton@linux.intel.com>
	<4E831868.4090603@gmail.com>
	<201109281432.57331.paul.eggleton@linux.intel.com>
In-Reply-To: <201109281432.57331.paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Subject: Re: [OE-core] meta-micro problems
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
X-List-Received-Date: Sat, 01 Oct 2011 18:06:41 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 09/28/2011 05:32 PM, Paul Eggleton wrote:
> On Wednesday 28 September 2011 13:51:52 Dmitry Eremin-Solenikov wrote:
>> If you wish, I can retry this with smaller layer set. But if the bug
>> will still arise, I simply have no knowledge/time to look deeper into bb
>> without additional input/pointers from bb gurus.
>
> That's OK, I can spend time looking into it. It sounds like a bug in bitbake
> if metadata can influence it to behave this way. If we can produce a simplified
> test case I think it will be easier to fix.

I have rechecked things on my test box, meta-micro still causes fails 
for me on rebuild. Setup:

I use setup-scripts from angstrom, change bblayers.conf to contain only 
oe-core and meta-micro, switched DISTRO to "micro", changed 
PARALLEL_MAKE to -j 4, BB_NUMBER_THREADS to 4, machine is qemuarm

Then:
1) bitbake pseudo-native succeeds
2) next bitbake pseudo-native fails. Usually in rm_work of any of the 
packages (automake-native,openssl-native,python-native are few to name).

-- 
With best wishes
Dmitry


