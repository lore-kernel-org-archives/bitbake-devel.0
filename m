Received: from mail-qc0-f175.google.com ([209.85.216.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SDVGo-0004eB-7L
	for bitbake-devel@lists.openembedded.org;
	Fri, 30 Mar 2012 08:25:10 +0200
Received: by qcso7 with SMTP id o7so160090qcs.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Mar 2012 23:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=8gQf+7Fzo9g4Ex3VSjx1QjchUTy7ZJMbP4wGxuytHsM=;
	b=Ul5HyhJ7DZGwLwp4MZTmfgMTim2LY4J8dnDSoVdw5SeEyBRcmiyKoO21Y2gKDY+SqS
	FyqPx+lCWIPdtOGZQ7StDhVCvESLy+g/eG32TStaOeZOgCvNI/cF15DaoeDz8D8cMmZ5
	uf6xm9UUqurmd/Ti1pmpkMwSytxYNAo3JqE0WMAZROON3AcaGXJw7l4Sn+8XNGt9j59w
	ODoSkDmTWWwxNOabLzp+ejP/2qxHyqY4TJ+VUoA68NZQyGVPf5EMVcPcgS8OiYJNzMmA
	TErRfehv7wU90GjwImUTiC7I+DqYDlEmO1596uOeTo8Bh8CcDk0BY+yBKohQG9oFnPVg
	go3g==
Received: by 10.224.207.70 with SMTP id fx6mr3749387qab.79.1333088165556; Thu,
	29 Mar 2012 23:16:05 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.229.158.11 with HTTP; Thu, 29 Mar 2012 23:15:45 -0700 (PDT)
In-Reply-To: <3AB6CE7F274E534CAFD089D127A8A1FC23AFEFBD@SHSMSX102.ccr.corp.intel.com>
References: <ae31cc41fb985bdc59e784dbf973c522b666553a.1333025490.git.shane.wang@intel.com>
	<b0f25a4ae7b257c5e0631a3e5c1f90facf25aca6.1333025491.git.shane.wang@intel.com>
	<1333051449.18082.10.camel@ted>
	<3AB6CE7F274E534CAFD089D127A8A1FC23AFEFBD@SHSMSX102.ccr.corp.intel.com>
From: Chris Larson <clarson@kergoth.com>
Date: Thu, 29 Mar 2012 23:15:45 -0700
X-Google-Sender-Auth: iVZzimds6K9AlUt0734B3hzfdYE
Message-ID: <CABcZAN=8f03au8SBnr8Y9t6u55y9EeRkVc=KfciBscSbSU42+g@mail.gmail.com>
To: "Wang, Shane" <shane.wang@intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 5/8] runqueue.py: check results[0] in keys of build_pids before being used to avoid exceptions
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
X-List-Received-Date: Fri, 30 Mar 2012 06:25:10 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 29, 2012 at 11:10 PM, Wang, Shane <shane.wang@intel.com> wrote:
>> So can you please explain the problem further so we can fix the real
>> problem? I did look at #2186 but that doesn't help me either :(
> OK, I am going to submit another patch, but I think the condition check i=
s also needed.
> Otherwise, in the current code of runqueue_process_waitpid(), why do we h=
ave:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if result[0] in self.build_stamps.keys():
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0del self.build_stamps[result[0]]

This is also off, from a code standpoint, even assuming it's needed.
There's no need to use the keys method at all for a map. 'in' against
a map automatically checks by key. result[0] in self.build_stamps.
--=20
Christopher Larson


