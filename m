Return-Path: <alex.r.damian@gmail.com>
Received: from mail-qc0-f174.google.com (mail-qc0-f174.google.com
	[209.85.216.174])
	by mail.openembedded.org (Postfix) with ESMTP id CB6E16B0F9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Oct 2013 15:37:26 +0000 (UTC)
Received: by mail-qc0-f174.google.com with SMTP id v1so880853qcw.19
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Oct 2013 08:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=ltPP4cXo+FWyf5xQ/xYk9oNzorgfrwYpeO62RyOxnZs=;
	b=LvBr6nBTZlYAlnUWTwNfLtBywODz0FKbsHvpWHEDKT8DQnKwGvYKsmpGjMVGiHMGFi
	8yXJX7i5TZLoI4stpPYimDj173PWH227zCIkGgUk84OzXVfd7sXPPUDDNMx2L6PU5heQ
	XDma2HQC8KyGSWAzA+1mlQkpitwSjLrrnnuJfgtAGo3aV73cfmehftPep1tD6bNi7QEB
	NEzSazPgLdpqmg2scgyQx7tRgY/VJiujrreXSMTGIWQbvTQpRn7kve3cUcNwIOB3gTLn
	qt92esuNpGrFDnLrJRzRTPPOfVs4kCKuqKO4iOU3RY3ViaI69j/dUlUChKE34w3aLC3O
	YeJg==
MIME-Version: 1.0
X-Received: by 10.49.94.72 with SMTP id da8mr7339776qeb.67.1383147448357; Wed,
	30 Oct 2013 08:37:28 -0700 (PDT)
Received: by 10.224.3.70 with HTTP; Wed, 30 Oct 2013 08:37:28 -0700 (PDT)
In-Reply-To: <1382959696-24874-1-git-send-email-cristiana.voicu@intel.com>
References: <1382959696-24874-1-git-send-email-cristiana.voicu@intel.com>
Date: Wed, 30 Oct 2013 15:37:28 +0000
Message-ID: <CAL7ttbe5fOBpiyL0qnZmmk1=b=N0WM5kk7OTT9kvDRobhjaS3w@mail.gmail.com>
From: Alex Damian <alex.r.damian@gmail.com>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] toaster: set INHERIT var in the script that starts toaster
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
X-List-Received-Date: Wed, 30 Oct 2013 15:37:28 -0000
Content-Type: multipart/alternative; boundary=047d7b5d4e3c54d8c204e9f71c06

--047d7b5d4e3c54d8c204e9f71c06
Content-Type: text/plain; charset=ISO-8859-1

Taken in toaster/master.


On Mon, Oct 28, 2013 at 11:28 AM, Cristiana Voicu <cristiana.voicu@intel.com
> wrote:

> In order to use toaster, now you have to set INHERIT+="toaster
> buildhistory"
> To keep it simple, I've done some changes in order to automate it. When
> toaster
> is started, this line is added to local.conf. When it is stoped, it is
> removed.
>
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
> ---
>  bitbake/bin/toaster |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/bitbake/bin/toaster b/bitbake/bin/toaster
> index 16de52b..639b7b7 100755
> --- a/bitbake/bin/toaster
> +++ b/bitbake/bin/toaster
> @@ -49,6 +49,21 @@ function webserverStartAll()
>          return $retval
>  }
>
> +#Helper functions to add/remove a line from a configuration file
> +
> +function addtoConfiguration()
> +{
> +        echo "#added by toaster" >> ${BUILDDIR}/conf/$2
> +        echo $1 >> ${BUILDDIR}/conf/$2
> +}
> +
> +function removefromConfiguration()
> +{
> +        comment_line=$(grep -n "#added by toaster" "$file" | cut -f1 -d:)
> +        variable_line=$((comment_line+1))
> +        lines="${comment_line},${variable_line}"
> +        sed -i "$lines"'d' ${BUILDDIR}/conf/$1
> +}
>
>  # We make sure we're running in the current shell and in a good
> environment
>
> @@ -120,6 +135,7 @@ fi
>
>  case $CMD in
>      start )
> +        addtoConfiguration "INHERIT+=\"toaster buildhistory\"" local.conf
>          webserverStartAll || return 4
>          unset BBSERVER
>          bitbake --server-only -t xmlrpc -B localhost:8200
> @@ -138,6 +154,7 @@ case $CMD in
>          webserverKillAll
>          # force stop any misbehaving bitbake server
>          lsof bitbake.lock | awk '{print $2}' | grep "[0-9]\+" | xargs -n1
> -r kill
> +        removefromConfiguration local.conf
>      ;;
>  esac
>
> --
> 1.7.9.5
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--047d7b5d4e3c54d8c204e9f71c06
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Taken in toaster/master.</div><div class=3D"gmail_extra"><=
br><br><div class=3D"gmail_quote">On Mon, Oct 28, 2013 at 11:28 AM, Cristia=
na Voicu <span dir=3D"ltr">&lt;<a href=3D"mailto:cristiana.voicu@intel.com"=
 target=3D"_blank">cristiana.voicu@intel.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">In order to use toaster, now you have to set=
 INHERIT+=3D&quot;toaster buildhistory&quot;<br>
To keep it simple, I&#39;ve done some changes in order to automate it. When=
 toaster<br>
is started, this line is added to local.conf. When it is stoped, it is remo=
ved.<br>
<br>
Signed-off-by: Cristiana Voicu &lt;<a href=3D"mailto:cristiana.voicu@intel.=
com">cristiana.voicu@intel.com</a>&gt;<br>
---<br>
=A0bitbake/bin/toaster | =A0 17 +++++++++++++++++<br>
=A01 file changed, 17 insertions(+)<br>
<br>
diff --git a/bitbake/bin/toaster b/bitbake/bin/toaster<br>
index 16de52b..639b7b7 100755<br>
--- a/bitbake/bin/toaster<br>
+++ b/bitbake/bin/toaster<br>
@@ -49,6 +49,21 @@ function webserverStartAll()<br>
=A0 =A0 =A0 =A0 =A0return $retval<br>
=A0}<br>
<br>
+#Helper functions to add/remove a line from a configuration file<br>
+<br>
+function addtoConfiguration()<br>
+{<br>
+ =A0 =A0 =A0 =A0echo &quot;#added by toaster&quot; &gt;&gt; ${BUILDDIR}/co=
nf/$2<br>
+ =A0 =A0 =A0 =A0echo $1 &gt;&gt; ${BUILDDIR}/conf/$2<br>
+}<br>
+<br>
+function removefromConfiguration()<br>
+{<br>
+ =A0 =A0 =A0 =A0comment_line=3D$(grep -n &quot;#added by toaster&quot; &qu=
ot;$file&quot; | cut -f1 -d:)<br>
+ =A0 =A0 =A0 =A0variable_line=3D$((comment_line+1))<br>
+ =A0 =A0 =A0 =A0lines=3D&quot;${comment_line},${variable_line}&quot;<br>
+ =A0 =A0 =A0 =A0sed -i &quot;$lines&quot;&#39;d&#39; ${BUILDDIR}/conf/$1<b=
r>
+}<br>
<br>
=A0# We make sure we&#39;re running in the current shell and in a good envi=
ronment<br>
<br>
@@ -120,6 +135,7 @@ fi<br>
<br>
=A0case $CMD in<br>
=A0 =A0 =A0start )<br>
+ =A0 =A0 =A0 =A0addtoConfiguration &quot;INHERIT+=3D\&quot;toaster buildhi=
story\&quot;&quot; local.conf<br>
=A0 =A0 =A0 =A0 =A0webserverStartAll || return 4<br>
=A0 =A0 =A0 =A0 =A0unset BBSERVER<br>
=A0 =A0 =A0 =A0 =A0bitbake --server-only -t xmlrpc -B localhost:8200<br>
@@ -138,6 +154,7 @@ case $CMD in<br>
=A0 =A0 =A0 =A0 =A0webserverKillAll<br>
=A0 =A0 =A0 =A0 =A0# force stop any misbehaving bitbake server<br>
=A0 =A0 =A0 =A0 =A0lsof bitbake.lock | awk &#39;{print $2}&#39; | grep &quo=
t;[0-9]\+&quot; | xargs -n1 -r kill<br>
+ =A0 =A0 =A0 =A0removefromConfiguration local.conf<br>
=A0 =A0 =A0;;<br>
=A0esac<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
1.7.9.5<br>
<br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" ta=
rget=3D"_blank">http://lists.openembedded.org/mailman/listinfo/bitbake-deve=
l</a><br>
</font></span></blockquote></div><br></div>

--047d7b5d4e3c54d8c204e9f71c06--
