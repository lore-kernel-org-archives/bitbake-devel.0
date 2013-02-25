Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1UA00H-0005fw-9R
	for bitbake-devel@lists.openembedded.org;
	Mon, 25 Feb 2013 16:30:15 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r1PFDljW019454
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 25 Feb 2013 07:13:47 -0800 (PST)
Received: from [172.25.32.35] (172.25.32.35) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.342.3;
	Mon, 25 Feb 2013 07:13:47 -0800
Message-ID: <512B7FA9.6030508@windriver.com>
Date: Mon, 25 Feb 2013 09:13:45 -0600
From: Jason Wessel <jason.wessel@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To: Chris Larson <clarson@kergoth.com>
References: <CALbNGRRDr+6vLtJRDgRi1NbO+s0sUB5TLT7uTck5L5La6xfDQw@mail.gmail.com>
	<CABcZANn3JbnhTEEP85K5bxXQd9ipYmuP9-bqMizpw+z9R3HhiQ@mail.gmail.com>
	<CAPhnLPCYxVk8F72Tv=PJo2OQJQmMdN0RKXNmTj_JeVy+7VJ+qA@mail.gmail.com>
	<CAPhnLPBwwM84Pu25od0pLr2446-RSbGsDHQbayQE3g+xNV2tkw@mail.gmail.com>
In-Reply-To: <CAPhnLPBwwM84Pu25od0pLr2446-RSbGsDHQbayQE3g+xNV2tkw@mail.gmail.com>
X-Enigmail-Version: 1.5
X-MIME-Autoconverted: from 8bit to quoted-printable by mail1.windriver.com id
	r1PFDljW019454
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: trouble during parsing
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
X-List-Received-Date: Mon, 25 Feb 2013 15:30:42 -0000
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 02/24/2013 08:28 PM, Flanagan, Elizabeth wrote:
> On Sun, Feb 24, 2013 at 6:12 PM, Flanagan, Elizabeth
> <elizabeth.flanagan@intel.com> wrote:
>> On Wed, Feb 20, 2013 at 6:31 AM, Chris Larson <clarson@kergoth.com> wr=
ote:
>>>
>>> On Wed, Feb 20, 2013 at 5:54 AM, Andreas M=FCller
>>> <schnitzeltony@googlemail.com> wrote:
>>>>
>>>> with current bitbake master I get
>>>>
>>>> ERROR: Command execution failed: Traceback (most recent call
>>>> last):#########################################################
>>>> | ETA: 00:00:17
>>>> File "/home/andreas/oe-core/sources/bitbake/lib/bb/command.py", line
>>>> 92, in runAsyncCommand
>>>> self.cooker.updateCache()
>>>> File "/home/andreas/oe-core/sources/bitbake/lib/bb/cooker.py", line
>>>> 1330, in updateCache
>>>> if not self.parser.parse_next():
>>>> File "/home/andreas/oe-core/sources/bitbake/lib/bb/cooker.py", line
>>>> 1703, in parse_next
>>>> self.virtuals +=3D len(result)
>>>> TypeError: object of type 'ExpansionError' has no len()
>>>
>>>
>>> Hmm, looks like it's returning the exceptions rather than raising the=
m, for
>>> some reason, but that doesn't make much sense =97 the pool code alway=
s raises
>>> any exceptions from its imap iterator's next() method.
>>
>
> Ach, should have updated my email. Seems reverting
> 0a99563a4ea270594fd9a61da46f9387fb79dc66 cleared up the issue.

The real question is what are the expansion errors about here.  This is p=
robably not the right way to fix it, but it at least allows you to see wh=
at is behind the expansion error:

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 448f899..b166425 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1661,6 +1661,8 @@ class CookerParser(object):
         parsed =3D None
         try:
             parsed, result =3D self.results.next()
+            if isinstance(result, BaseException):
+                raise result
         except StopIteration:
             self.shutdown()
             return False




