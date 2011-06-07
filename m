Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1QU5XV-0005KP-Ou
	for bitbake-devel@lists.openembedded.org;
	Wed, 08 Jun 2011 01:18:27 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p57MGPwI017920
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 7 Jun 2011 15:16:25 -0700 (PDT)
Received: from Macintosh-5.local (172.25.36.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Tue, 7 Jun 2011 15:16:25 -0700
Message-ID: <4DEEA338.6070904@windriver.com>
Date: Tue, 7 Jun 2011 17:16:24 -0500
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US;
	rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <1306882804.27470.402.camel@rex>
	<1307484603.15327.16.camel@scimitar>
In-Reply-To: <1307484603.15327.16.camel@scimitar>
Subject: Re: RFC: Override expansion - changing the behaviour
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
X-List-Received-Date: Tue, 07 Jun 2011 23:18:27 -0000
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On 6/7/11 5:10 PM, Joshua Lock wrote:
> On Wed, 2011-06-01 at 00:00 +0100, Richard Purdie wrote:
>> Currently if you do:
>>
>> OVERRIDES = "z"
>> DEPENDS_prepend = "a "
>> DEPENDS = "b"
>> DEPENDS_z = "c"
>>
>> d.update_data()
>> d.getVar("DEPENDS") gives "a c"
>> d.update_data()
>> d.getVar("DEPENDS") gives "c"
>>
>> I'm proposing we should change the bitbake behaviour such that at the
>> time bitbake expands the DEPENDS_z override, it removes "DEPENDS_z" from
>> the data store.
> 
> FWIW I think this change is absolutely the right thing to do. The
> current behaviour always catches me out (and I hope I'm not alone) and
> changing it as suggested makes the behaviour much less surprising.
> 
> Cheers,
> Joshua

We will likely need to audit the classes.  I've seen places (in the past, they
may all be gone now) where we've got things like getVar("DEPENDS"), and later
getVar("DEPENDS_${PN}"... where PN is the override...

But more consistent behavior is certainly better..  (Maybe simply clearing the
OVERRIDES, once its been applied is an alternative?)

--Mark


