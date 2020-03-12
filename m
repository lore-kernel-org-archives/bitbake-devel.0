Return-Path: <rp@stacktrust.org>
X-Greylist: delayed 302 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 12 Mar 2020 23:55:53 UTC
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	by mail.openembedded.org (Postfix) with ESMTP id 2DDA061C7B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2020 23:55:53 +0000 (UTC)
Received: from [100.64.72.37] ([173.245.215.240]) by mrelay.perfora.net
	(mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
	0MfFYy-1iwWsS2u2E-00Oro7; Fri, 13 Mar 2020 00:50:50 +0100
From: Rich Persaud <rp@stacktrust.org>
Mime-Version: 1.0 (1.0)
Date: Thu, 12 Mar 2020 19:50:49 -0400
Message-Id: <172109D8-BB79-48CB-93EB-C65C07EAE62A@stacktrust.org>
References: <20200309163353.15362-16-JPEWhacker@gmail.com>
In-Reply-To: <20200309163353.15362-16-JPEWhacker@gmail.com>
To: docs@lists.yoctoproject.org, Joshua Watt <jpewhacker@gmail.com>
X-Mailer: iPad Mail (17D50)
X-Provags-ID: V03:K1:hG/upTiG00zHe3UgEmG2ZBPxlxE7PXPkPNoZytNdBN9ORw/L7Z/
	nxKWJmj0GHXysAWnClk9NDgyJw2Z+pFPIw89dlET77Ll5tY4vtSjyOJ0Nl4gc5bwYsBMXId
	vktauo8jpi14rugO34UPYSF7wYonf0nBrhmgbExwJ0O0pPbjmvuXq3ZJ3jSL6B7ahpI3bFl
	hpc0pPjfbul+ZndfupB+g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AiUn4EbPt3Y=:3fRsyEQYDYZAkhgkPbnwiF
	JBbpXgq42/4SaBeh9LQfsUL+nADeQnMj+neCoS2uxraJ55IJtF/MpM3fnkfsByZhfKBXERo71
	IvDOpiKvearOA7Z34BaXgbPaLzGl69jOc4RhLmMPlyUGnANKCkAeON5IvlWws8XO+NVh+2jhZ
	LqBDfeL0/TIknc5eU0gBg8faQmuraqo8zZolk7arH0dxqKrVe6DQZ0WYPbnWF/98cVjGr4H10
	OCV20zcDI07bMWDdmfgKjmTd/8dXegqDZdyrWCBorTLKG3FOgLQ0jSE4t/+Eu7ooIlWrbbBbl
	pn2O1QlCvIVPEqjFrDit5gkDmeRK0VkSBEy3mYZEpL7Px0XlL0iKfZ0nMv5sjwyJZFaW/xh9s
	09uf+7c1hdgWomURIVs9B+2qduEROYZD6h2H007KQASYPvyo1dOfXw5G25Et766L4tyUyfasG
	DrnJdZvF9AYIo+ZtMJX51Rx2mzbyar56jE+22Z1Orwrq8gbzH1yGT4+h6yek3Cgkat402SI2A
	ug3pcEvqhqvxLp6KkyLjbMy67begZ9yrR3sFaGL1/DW/KknKz9RiTb5zZdzEAwVKlARPmollY
	pkaf5EliS7m2eB+JVIgok+wDNWCpTSNDI1V/weYbu5i32K46ueILxECewWTxegB3EwHUJDsYH
	DarRZ0h4PWe8/PDsQOQfMIZPY2XFjtkkTguK3Zh7WjqWu44DJEG8AvCJrsDSJPfwqJP2M5h5s
	NetsMtN/vGsPAZ5oOxaKSXFhvktRkNaKZCPDoMQCVTnb3XKqIkgxyd7pqy53oP7OpYlVrbMsx
	zO/6DytT84tmxBqd3XwxUw/adkwhoDMw1nt+J+K6Mm9C6MD0M0Y6jHrbwuQd5A4Hhvi7KjQ
X-Mailman-Approved-At: Fri, 13 Mar 2020 07:18:38 +0000
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [docs] [PATCH 15/15] bitbake-user-manual: Add documentation for BB_LOGCONFIG
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 12 Mar 2020 23:55:54 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mar 9, 2020, at 12:34, Joshua Watt <jpewhacker@gmail.com> wrote:
>=20
> =EF=BB=BFAdds documentation describing how to use the BB_LOGCONFIG variabl=
e to
> enable custom logging.
>=20
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
> .../bitbake-user-manual-execution.xml         | 97 +++++++++++++++++++
> .../bitbake-user-manual-ref-variables.xml     | 11 +++
> 2 files changed, 108 insertions(+)
>=20
> diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution=
.xml b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
> index 8f606676b4..3b31f748cc 100644
> --- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
> +++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
> @@ -929,4 +929,101 @@
>             section.
>         </para>
>     </section>
> +
> +    <section id=3D"logging">
> +        <title>Logging</title>
> +        <para>
> +            In addition to the standard command line option to control ho=
w
> +            verbose builds are when execute, bitbake also supports user d=
efined
> +            configuration of the
> +            <ulink url=3D'https://docs.python.org/3/library/logging.html'=
>Python logging</ulink>
> +            facilities through the
> +            <link linkend=3D"var-bb-BB_LOGCONFIG"><filename>BB_LOGCONFIG<=
/filename></link>
> +            variable. This variable defines a json or yaml
> +            <ulink url=3D'https://docs.python.org/3/library/logging.confi=
g.html'>logging configuration</ulink>
> +            that will be intelligently merged into the default configurat=
ion.
> +            The logging configuration is merged using the following rules=
:
> +            <itemizedlist>
> +                <listitem><para>
> +                    The user defined configuration will completely replac=
e the default
> +                    configuration if top level key
> +                    <filename>bitbake_merge</filename> is set to the valu=
e
> +                    <filename>False</filename>. In this case, all other r=
ules
> +                    are ignored.
> +                </para></listitem>
> +                <listitem><para>
> +                    The user configuration must have a top level
> +                    <filename>version</filename> which must match the val=
ue of
> +                    the default configuration.
> +                </para></listitem>
> +                <listitem><para>
> +                    Any keys defined in the <filename>handlers</filename>=
,
> +                    <filename>formatters</filename>, or <filename>filters=
</filename>,
> +                    will be merged into the same section in the default
> +                    configuration, with the user specified keys taking
> +                    replacing a default one if there is a conflict. In
> +                    practice, this means that if both the default configu=
ration
> +                    and user configuration specify a handler named
> +                    <filename>myhandler</filename>, the user defined one w=
ill
> +                    replace the default. To prevent the user from inadver=
tently
> +                    replacing a default handler, formatter, or filter, al=
l of
> +                    the default ones are named with a prefix of
> +                    "<filename>BitBake.</filename>"
> +                </para></listitem>
> +                <listitem><para>
> +                    If a logger is defined by the user with the key
> +                    <filename>bitbake_merge</filename> set to
> +                    <filename>False</filename>, that logger will be compl=
etely
> +                    replaced by user configuration. In this case, no othe=
r
> +                    rules will apply to that logger.
> +                </listitem></para>
> +                <listitem><para>
> +                    All user defined <filename>filter</filename> and
> +                    <filename>handlers</filename> properties for a given l=
ogger
> +                    will be merged with corresponding properties from the=

> +                    default logger. For example, if the user configuratio=
n adds
> +                    a filter called <filename>myFilter</filename> to the
> +                    <filename>BitBake.SigGen</filename>, and the default
> +                    configuration adds a filter called
> +                    <filename>BitBake.defaultFilter</filename>, both filt=
ers
> +                    will be applied to the logger
> +                </listitem></para>
> +            </itemizedlist>
> +        </para>
> +
> +        <para>
> +            As an example, consider the following user logging configurat=
ion
> +            file which logs all Hash Equivalence related messages of VERB=
OSE or
> +            higher to a file called <filename>hashequiv.log</filename>
> +            <literallayout class=3D'monospaced'>
> +    {
> +        "version": 1,
> +        "handlers": {
> +            "autobuilderlog": {
> +                "class": "logging.FileHandler",
> +                "formatter": "logfileFormatter",
> +                "level": "DEBUG",
> +                "filename": "hashequiv.log",
> +                "mode": "w"
> +            }
> +        },
> +        "formatters": {
> +                "logfileFormatter": {
> +                    "format": "%(name)s: %(levelname)s: %(message)s"

What's the syntax for including a timestamp in the log message?  Or is that i=
mplicit?

Rich=


