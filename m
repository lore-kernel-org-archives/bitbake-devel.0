Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <otavio.salvador@gmail.com>)
	id 1RA3j9-0005aN-UM; Sat, 01 Oct 2011 19:51:56 +0200
Received: by bke11 with SMTP id 11so3247230bke.6
	for <multiple recipients>; Sat, 01 Oct 2011 10:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:date
	:x-google-sender-auth:message-id:subject:from:to:cc:content-type
	:content-transfer-encoding;
	bh=IXEzEABLbE3F1ZisndxeVS1TeJcoSC7qgWaDBeA2ncg=;
	b=Sn+ZYafk8xgjPTSypSdIkohNDpSNQx+sAZgsmkjPjdmQHnQK/q4o2xjeF4sAC6Aibb
	I5bqCMWROY4etMwYH2o3hfK3HQNnGhk1g+bwN7w6xVDZsMCZ7PEs1Ov5EsFL0Uju84zX
	9+gC4n4IJiSH5GE3D4QNgE4oD7FtgTTi/soHY=
MIME-Version: 1.0
Received: by 10.204.138.193 with SMTP id b1mr8677023bku.114.1317491185270;
	Sat, 01 Oct 2011 10:46:25 -0700 (PDT)
Sender: otavio.salvador@gmail.com
Received: by 10.204.35.198 with HTTP; Sat, 1 Oct 2011 10:46:25 -0700 (PDT)
In-Reply-To: <33AB447FBD802F4E932063B962385B3512DAF448FB@shsmsx501.ccr.corp.intel.com>
References: <4E85D3E0.7070807@intel.com> <4E863AE8.7020901@mlbassoc.com>
	<33AB447FBD802F4E932063B962385B3512DAF448FB@shsmsx501.ccr.corp.intel.com>
Date: Sat, 1 Oct 2011 14:46:25 -0300
X-Google-Sender-Auth: IAxt3DBdb_HeusFjC7hyPJiPKWs
Message-ID: <CAP9ODKpnvcCJWCYDMbyL5n_HDjxb+6cwy54BWTaXqM2eH5=G_w@mail.gmail.com>
From: Otavio Salvador <otavio@ossystems.com.br>
To: Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
X-Mailman-Approved-At: Wed, 05 Oct 2011 15:27:42 +0200
Cc: "Lock, Joshua" <joshua.lock@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Gary Thomas <gary@mlbassoc.com>
Subject: Re: [OE-core] Feedback on HOB (new image creator GUI)
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
X-List-Received-Date: Sat, 01 Oct 2011 17:51:56 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 30, 2011 at 21:23, Yu, Ke <ke.yu@intel.com> wrote:
...
> So currently, if you name your own image with XXX-image, HOB should be ab=
le to automatically add it in the drop-down list.
>
> And yes, it is helpful to allow user adding item into base image list. it=
 can be done by adding one item in "Edit"->"Preference". I will add this re=
quirement to my plan. For base image filtering, I am not sure if it is nece=
ssary, since base image list is not that long. How do you think?
...

It would be nice to have a way to filter out images too. In case we're
customizing oe-core to a customer we might want to reduce the options
to avoid unsupported images to be built.

--=20
Otavio Salvador=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0O=
.S. Systems
E-mail: otavio@ossystems.com.br=A0 http://www.ossystems.com.br
Mobile: +55 53 9981-7854=A0 =A0 =A0 =A0=A0 =A0 =A0 =A0http://projetos.ossys=
tems.com.br


