Received: from mail-vw0-f47.google.com ([209.85.212.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1Qs1Hv-0007Eb-Mt
	for bitbake-devel@lists.openembedded.org;
	Sat, 13 Aug 2011 01:37:15 +0200
Received: by vwe42 with SMTP id 42so1735953vwe.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Aug 2011 16:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=4yTsnElJZIBbWasi256kazSis8Mx3oxxwRz19a7YVtk=;
	b=oav3RgfFwqdDYFyVBwSsKX78p/3pp/yPPBRGtCEg3o4n0dEtlDcEt17yj54RyNqGNU
	5dvKCxy20f3CpmYLyMcZQ+jgA4pB8k/gho7mOzTda0ClYWgoim65rr5ykzg2aeMIrihD
	68fiVJjExwDRf/e6x4HGuxLBKndIidunpKG30=
Received: by 10.52.95.229 with SMTP id dn5mr817707vdb.431.1313191962050; Fri,
	12 Aug 2011 16:32:42 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.52.112.194 with HTTP; Fri, 12 Aug 2011 16:32:22 -0700 (PDT)
In-Reply-To: <1313191795.2228.6.camel@scimitar>
References: <CAJzOQw3V_tsUh1CW7JDTswYkcvrUPGHfd6vhHQnd3Lrp1enJOw@mail.gmail.com>
	<1313191795.2228.6.camel@scimitar>
From: Chris Larson <clarson@kergoth.com>
Date: Fri, 12 Aug 2011 16:32:22 -0700
X-Google-Sender-Auth: OG61rlx_XzVNgbF5UKHj8wKGJ6w
Message-ID: <CABcZANki4ULpVxRYM9EPA05ZEWHY6g+Fnr_0ntQDjKPcZ_WSnQ@mail.gmail.com>
To: Joshua Lock <josh@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Conditional assignment broken
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
X-List-Received-Date: Fri, 12 Aug 2011 23:37:15 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 12, 2011 at 4:29 PM, Joshua Lock <josh@linux.intel.com> wrote:
> On Sat, 2011-08-13 at 06:50 +0800, James Limbouris wrote:
>> Hi,
>>
>> =C2=A0Commit 21c21fcc5871e81d8d497b6baed605cdd74c4571 breaks conditional=
 assignment
>> =C2=A0in all conf files. Previously, the environment was copied from a
>> cleaned up os environment.
>> =C2=A0After the commit, a pristine environment is available in
>> data['_data'], and will be copied to
>> =C2=A0data[] on conditional assignment, defying BB_ENV_EXTRAWHITE.
>> Variables not conditionally
>> =C2=A0assigned will still be available from data['_data'], also in defia=
nce
>> of BB_ENV_EXTRAWHITE.
>>
>> =C2=A0To verify, simply:
>>
>> =C2=A0export RANDOMENV=3D42
>> =C2=A0bitbake -e | grep RANDOMENV
>
> Thanks for the report James, and apologies for the breakage. I'll try
> and get a fix submitted and merged asap.
>
> I'm now wondering if we want the pristine environment, or the cleaned
> environment, saved.

For things like devshell, I think it would be nice to retain a copy of
the original, unmodified environment.
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics


