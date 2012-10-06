Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TKdE9-0004s9-Bf
	for bitbake-devel@lists.openembedded.org;
	Sun, 07 Oct 2012 00:52:09 +0200
Received: by mail-lb0-f175.google.com with SMTP id y2so1984427lbk.6
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 06 Oct 2012 15:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=uGOni+3KCHEEx/325fFfw4kRm+skUjaSSn6LpaSLpUI=;
	b=PgXI619YXTQTo4XZ00D6GCn6eTsPPZ0VpIh9tzl5b8a1gItAA0ZoTl4N20OtSwx0Za
	5S1m0lG7WutGbgWJ6e4tiufbSoSOvBlNKjRCT5NmgG1PNxJx626LDC+zxZmrSU8f9BOE
	uUEb4uJgzAhrtkdJl0utJNeqnYBRYmXrLcW9zQy0lKE0ndTQFkucDJKaZ3oRceClC3Rf
	PCb72vcdgKsuGUChoMbm1n6BWKA8G+vhOQuAong+g8iBuiUQ5o6VS1N6qt82OziseBgE
	MarjWAboaxkGZmuyp0z2buGCc2eL4GYaITnpD06N8UNdTV54zmm7uDLX95Byl141lwih
	Gc0A==
Received: by 10.152.122.11 with SMTP id lo11mr4438247lab.3.1349563145288; Sat,
	06 Oct 2012 15:39:05 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.114.19.2 with HTTP; Sat, 6 Oct 2012 15:38:45 -0700 (PDT)
In-Reply-To: <2059965.DPhKPFNMcC@helios>
References: <1349267277-1380-1-git-send-email-paul.eggleton@linux.intel.com>
	<CABcZAN=FnKvxMDB_WHVdAXFz66RMXWtV-9yhHc7D=NpfY=VmMA@mail.gmail.com>
	<2059965.DPhKPFNMcC@helios>
From: Chris Larson <clarson@kergoth.com>
Date: Sat, 6 Oct 2012 15:38:45 -0700
X-Google-Sender-Auth: JxY1wM01u_o-he_4_kfGpUOLhb8
Message-ID: <CABcZAN=iu0M2T+wUQNAy9gGcFALvvVSPUPUNdGqB+bauK3_B1w@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2: raise an exception if user specifies protocol=git with http://
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
X-List-Received-Date: Sat, 06 Oct 2012 22:52:09 -0000
Content-Type: text/plain; charset=UTF-8

On Sat, Oct 6, 2012 at 3:32 PM, Paul Eggleton
<paul.eggleton@linux.intel.com> wrote:
> On Saturday 06 October 2012 15:27:42 Chris Larson wrote:
>> On Wed, Oct 3, 2012 at 5:27 AM, Paul Eggleton
>>
>> <paul.eggleton@linux.intel.com> wrote:
>> > It is a common mistake to use http:// and protocol=git when attempting
>> > to fetch from a git repository using the http protocol; if this is
>> > detected then throw an error explaining that you need to use git:// with
>> > protocol=http instead.
>> >
>> > Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
>>
>> Perhaps this should check the protocol= value against the protocols
>> supported by wget (ftp, http, https, etc), if the parameter is passed,
>> rather than hardcoding the exceptions.
>
> I don't think protocol= is currently used with the wget fetcher is it?

It isn't, but it also doesn't seem ideal to hardcode knowledge of the
git fetcher in the wget one. Either way, I just wanted to make sure
both options were considered.
-- 
Christopher Larson


