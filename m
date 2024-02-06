Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880C3C48297
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 15:26:47 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web10.24179.1707233203369948771
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Feb 2024 07:26:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=DUef8e8w;
 spf=pass (domain: snapchat.com, ip: 209.85.218.54, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a37878ac4f4so323390666b.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Feb 2024 07:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1707233202; x=1707838002; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ID4RuNJZJR5YBqUAGYQB8+0zYLCf9w+5TqWJ7Ne9qO8=;
        b=DUef8e8wtoldT1CS2qebVpCpB4qA/bWr8BZBPYJ1C/npqyAskzQyYufuReLSIu/w1l
         fhlh24e1qCPADB+UcrpN3Qt6eRACUcg8B6lRGE6Npx/R3JS2MHUdmKd6pG3DWLGH9n7+
         tc/ExQipPpcGaid7d0le7hZMthtSOfJ7nYcLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707233202; x=1707838002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ID4RuNJZJR5YBqUAGYQB8+0zYLCf9w+5TqWJ7Ne9qO8=;
        b=n8qQ2lIhANj+vn4ecwDQs0wBjPZomJve9tcNugCquOHRC0XYQ+AU2t2ZAIPW7oNjWz
         JBEn9ikdgtDzcXeK0ydgVdhTzyzuz2Y1e81V5YhV/hprNNjVnobGbgLzswBQ/xY1atS2
         IT6Jjardj4XmI8qYFM1FvnVovxWFFQpYjTL2aaIs1qlMNra+MSqYZq7D2nMLA65W+hym
         EptdnJrjIQlQodpoqfcLrUVCo9Zy9+2FH6RIhkXdCdtpaSkyxt5hPFygOg9ywrAuKTE0
         EpYQwvuf6Bd0pWs67g1kMmtgKepv9rY/ActxbjbPlSuRbE6fNzgrqyLIhurX5GlpNCDi
         HHeA==
X-Gm-Message-State: AOJu0Yyvv0denSplWkqIV4uHRBczJl7whnlySiTa+a5CER+Ev2eeUPTc
	Vs9lQqrfRIiIeLxFwVjI55K4fIft+FTPqgX0QUG/tjPmmF2Aeo51u238tgu0rxa+lvsGZ2zdO1Z
	cNNsWrXDgkMf+VoBv/bBuJlt0R66Uj4dovSyzEQ==
X-Google-Smtp-Source: AGHT+IF39C2j2JqL8q0obDmiBHSx1JbyV6EWkBE1uarqK5MeUBYYATiNYODe1TS5nHcgGVkiDLbHU6ykqdOiNuPvx0M=
X-Received: by 2002:a17:906:4a56:b0:a37:f8dd:ba4 with SMTP id
 a22-20020a1709064a5600b00a37f8dd0ba4mr2348280ejv.41.1707233201480; Tue, 06
 Feb 2024 07:26:41 -0800 (PST)
MIME-Version: 1.0
References: <20240206121528.2581233-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20240206121528.2581233-1-richard.purdie@linuxfoundation.org>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Tue, 6 Feb 2024 16:26:30 +0100
Message-ID: <CAHUKmYbjs=_ijo2Jy5a1JCx5jrSJB5Ucoza99yBL2ya+qvwpRg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] lib/bb: Drop BBFILE_PRIORITY support
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000864b990610b83445"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Feb 2024 15:26:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15829

--000000000000864b990610b83445
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard, there is a word missing in the commit message:
" The functionality had a and place" -> "the functionality had a time and
place"
Also a typo: "comparibility" -> " compatibility "

What is the correct way to set layer priorities after this patch (I'm
asking because the BSP I'm using makes use of BBFILE_PRIORITY)?

Etienne

On Tue, Feb 6, 2024 at 1:15=E2=80=AFPM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> These entries, usually in layer.conf are part of an old, pre-layers
> part of bitbake for overlay/collection support. This is not really
> used any more and was replaced by the idea of layers.
>
> In a recent discussion, we asked the question "When do you need to
> use proprities?" and the answer was "almost never" given all the other
> tools and techniques now available in layers.
>
> These layer priorities cause users huge amounts of confusion. It is
> unclear to people how the "magic values" work if it is unset
> and if they are set differently, users don't expect the way it
> actually works and the effects it has between layers.
>
> In discussions I've had, there has been surprisingly strong support
> for removing them entirely, even if that does means we'd need to fix
> some corner caes.
>
> I wholly agree and support that idea, so lets remove the support
> and take a simplification where we can. The functionality had a
> and place but it has passed and we've moved on.
>
> Developers are about to need to change layer.conf to update the
> series comparibility for the next release so it is a good time to
> do it.
>
> This patch removes the core support and replaces it with a warning.
> It does not chase down every last reference or function parmeter,
> that can follow as time allows.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/cache.py     |  1 -
>  lib/bb/cooker.py    | 51 +++++++--------------------------------
>  lib/bb/providers.py | 58 +++++++++++++++++++--------------------------
>  lib/bb/utils.py     |  2 +-
>  4 files changed, 34 insertions(+), 78 deletions(-)
>
> diff --git a/lib/bb/cache.py b/lib/bb/cache.py
> index 18d5574a31..64dbffc0f6 100644
> --- a/lib/bb/cache.py
> +++ b/lib/bb/cache.py
> @@ -818,7 +818,6 @@ class CacheData(object):
>          # Indirect Cache variables (set elsewhere)
>          self.ignored_dependencies =3D []
>          self.world_target =3D set()
> -        self.bbfile_priority =3D {}
>
>      def add_from_recipeinfo(self, fn, info_array):
>          for info in info_array:
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index c5bfef55d6..381379086a 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -1124,26 +1124,15 @@ class BBCooker:
>          errors =3D False
>          self.bbfile_config_priorities =3D []
>          if collections:
> -            collection_priorities =3D {}
>              collection_depends =3D {}
>              collection_list =3D collections.split()
>              min_prio =3D 0
>              for c in collection_list:
>                  bb.debug(1,'Processing %s in collection list' % (c))
>
> -                # Get collection priority if defined explicitly
>                  priority =3D self.data.getVar("BBFILE_PRIORITY_%s" % c)
>                  if priority:
> -                    try:
> -                        prio =3D int(priority)
> -                    except ValueError:
> -                        parselog.error("invalid value for
> BBFILE_PRIORITY_%s: \"%s\"", c, priority)
> -                        errors =3D True
> -                    if min_prio =3D=3D 0 or prio < min_prio:
> -                        min_prio =3D prio
> -                    collection_priorities[c] =3D prio
> -                else:
> -                    collection_priorities[c] =3D None
> +                    bb.warn("Ignoring obsolete BBFILE_PRIORITY_%s" % c)
>
>                  # Check dependencies and store information for priority
> calculation
>                  deps =3D self.data.getVar("LAYERDEPENDS_%s" % c)
> @@ -1204,22 +1193,9 @@ class BBCooker:
>                          else:
>                              parselog.debug3("Layer '%s' recommends layer
> '%s', but this layer is not enabled in your configuration", c, rec)
>
> -            # Recursively work out collection priorities based on
> dependencies
> -            def calc_layer_priority(collection):
> -                if not collection_priorities[collection]:
> -                    max_depprio =3D min_prio
> -                    for dep in collection_depends[collection]:
> -                        calc_layer_priority(dep)
> -                        depprio =3D collection_priorities[dep]
> -                        if depprio > max_depprio:
> -                            max_depprio =3D depprio
> -                    max_depprio +=3D 1
> -                    parselog.debug("Calculated priority of layer %s as
> %d", collection, max_depprio)
> -                    collection_priorities[collection] =3D max_depprio
> -
> -            # Calculate all layer priorities using calc_layer_priority
> and store in bbfile_config_priorities
> +
> +            # Store all layer priorities in bbfile_config_priorities
>              for c in collection_list:
> -                calc_layer_priority(c)
>                  regex =3D self.data.getVar("BBFILE_PATTERN_%s" % c)
>                  if regex is None:
>                      parselog.error("BBFILE_PATTERN_%s not defined" % c)
> @@ -1236,7 +1212,7 @@ class BBCooker:
>                          parselog.error("BBFILE_PATTERN_%s \"%s\" is not =
a
> valid regular expression", c, regex)
>                          errors =3D True
>                          continue
> -                self.bbfile_config_priorities.append((c, regex, cre,
> collection_priorities[c]))
> +                self.bbfile_config_priorities.append((c, regex, cre, 0))
>          if errors:
>              # We've already printed the actual error(s)
>              raise CollectionError("Errors during parsing layer
> configuration")
> @@ -1358,7 +1334,6 @@ class BBCooker:
>          # Tweak some variables
>          item =3D info_array[0].pn
>          self.recipecaches[mc].ignored_dependencies =3D set()
> -        self.recipecaches[mc].bbfile_priority[fn] =3D 1
>          self.configuration.limited_deps =3D True
>
>          # Remove external dependencies
> @@ -1639,7 +1614,7 @@ class BBCooker:
>              self.show_appends_with_no_recipes()
>              self.handlePrefProviders()
>              for mc in self.multiconfigs:
> -                self.recipecaches[mc].bbfile_priority =3D
> self.collections[mc].collection_priorities(self.recipecaches[mc].pkg_fn,
> self.parser.mcfilelist[mc], self.data)
> +
> self.collections[mc].collection_priorities(self.recipecaches[mc].pkg_fn,
> self.parser.mcfilelist[mc], self.data)
>              self.state =3D state.running
>
>              # Send an event listing all stamps reachable after parsing
> @@ -1767,9 +1742,9 @@ class CookerCollectFiles(object):
>          self.bbfile_config_priorities =3D sorted(priorities, key=3Dlambd=
a
> tup: tup[1], reverse=3DTrue)
>
>      def calc_bbfile_priority(self, filename):
> -        for layername, _, regex, pri in self.bbfile_config_priorities:
> +        for layername, _, regex, _ in self.bbfile_config_priorities:
>              if regex.match(filename):
> -                return pri, regex, layername
> +                return 0, regex, layername
>          return 0, None, None
>
>      def get_bbfiles(self):
> @@ -1801,10 +1776,6 @@ class CookerCollectFiles(object):
>
>          files =3D (config.getVar( "BBFILES") or "").split()
>
> -        # Sort files by priority
> -        files.sort( key=3Dlambda fileitem:
> self.calc_bbfile_priority(fileitem)[0] )
> -        config.setVar("BBFILES_PRIORITIZED", " ".join(files))
> -
>          if not files:
>              files =3D self.get_bbfiles()
>
> @@ -1926,12 +1897,10 @@ class CookerCollectFiles(object):
>          return tuple(filelist)
>
>      def collection_priorities(self, pkgfns, fns, d):
> -        # Return the priorities of the entries in pkgfns
> -        # Also check that all the regexes in
> self.bbfile_config_priorities are used
> +        # Check that all the regexes in self.bbfile_config_priorities ar=
e
> used
>          # (but to do that we need to ensure skipped recipes aren't
> counted, nor
>          # collections in BBFILE_PATTERN_IGNORE_EMPTY)
>
> -        priorities =3D {}
>          seen =3D set()
>          matched =3D set()
>
> @@ -1943,7 +1912,7 @@ class CookerCollectFiles(object):
>          # Calculate priorities for each file
>          for p in pkgfns:
>              realfn, cls, mc =3D bb.cache.virtualfn2realfn(p)
> -            priorities[p], regex, _ =3D self.calc_bbfile_priority(realfn=
)
> +            _, regex, _ =3D self.calc_bbfile_priority(realfn)
>              if regex in unmatched_regex:
>                  matched_regex.add(regex)
>                  unmatched_regex.remove(regex)
> @@ -1985,8 +1954,6 @@ class CookerCollectFiles(object):
>                      collectlog.warning("No bb files in %s matched
> BBFILE_PATTERN_%s '%s'" % (self.mc if self.mc else 'default',
>
>                     collection, pattern))
>
> -        return priorities
> -
>  class ParsingFailure(Exception):
>      def __init__(self, realexception, recipe):
>          self.realexception =3D realexception
> diff --git a/lib/bb/providers.py b/lib/bb/providers.py
> index e11a4637d1..f527dc469f 100644
> --- a/lib/bb/providers.py
> +++ b/lib/bb/providers.py
> @@ -71,21 +71,15 @@ def sortPriorities(pn, dataCache, pkg_pn =3D None):
>      files =3D pkg_pn[pn]
>      priorities =3D {}
>      for f in files:
> -        priority =3D dataCache.bbfile_priority[f]
>          preference =3D dataCache.pkg_dp[f]
> -        if priority not in priorities:
> -            priorities[priority] =3D {}
> -        if preference not in priorities[priority]:
> -            priorities[priority][preference] =3D []
> -        priorities[priority][preference].append(f)
> -    tmp_pn =3D []
> -    for pri in sorted(priorities):
> -        tmp_pref =3D []
> -        for pref in sorted(priorities[pri]):
> -            tmp_pref.extend(priorities[pri][pref])
> -        tmp_pn =3D [tmp_pref] + tmp_pn
> -
> -    return tmp_pn
> +        if preference not in priorities:
> +            priorities[preference] =3D []
> +        priorities[preference].append(f)
> +    tmp_pref =3D []
> +    for pref in sorted(priorities):
> +        tmp_pref.extend(priorities[pref])
> +
> +    return tmp_pref
>
>  def versionVariableMatch(cfgData, keyword, pn):
>      """
> @@ -115,7 +109,7 @@ def preferredVersionMatch(pe, pv, pr, preferred_e,
> preferred_v, preferred_r):
>                  return True
>      return False
>
> -def findPreferredProvider(pn, cfgData, dataCache, pkg_pn =3D None, item =
=3D
> None):
> +def findPreferredProvider(pn, cfgData, dataCache, pkg_pn, item):
>      """
>      Find the first provider in pkg_pn with REQUIRED_VERSION or
> PREFERRED_VERSION set.
>      """
> @@ -156,15 +150,12 @@ def findPreferredProvider(pn, cfgData, dataCache,
> pkg_pn =3D None, item =3D None):
>              preferred_e =3D None
>              preferred_r =3D None
>
> -        for file_set in pkg_pn:
> -            for f in file_set:
> -                pe, pv, pr =3D dataCache.pkg_pepvpr[f]
> -                if preferredVersionMatch(pe, pv, pr, preferred_e,
> preferred_v, preferred_r):
> -                    preferred_file =3D f
> -                    preferred_ver =3D (pe, pv, pr)
> -                    break
> -            if preferred_file:
> -                break;
> +        for f in pkg_pn:
> +            pe, pv, pr =3D dataCache.pkg_pepvpr[f]
> +            if preferredVersionMatch(pe, pv, pr, preferred_e,
> preferred_v, preferred_r):
> +                preferred_file =3D f
> +                preferred_ver =3D (pe, pv, pr)
> +                break
>          if preferred_r:
>              pv_str =3D '%s-%s' % (preferred_v, preferred_r)
>          else:
> @@ -175,14 +166,13 @@ def findPreferredProvider(pn, cfgData, dataCache,
> pkg_pn =3D None, item =3D None):
>              if not required:
>                  logger.warning("preferred version %s of %s not
> available%s", pv_str, pn, itemstr)
>              available_vers =3D []
> -            for file_set in pkg_pn:
> -                for f in file_set:
> -                    pe, pv, pr =3D dataCache.pkg_pepvpr[f]
> -                    ver_str =3D pv
> -                    if pe:
> -                        ver_str =3D "%s:%s" % (pe, ver_str)
> -                    if not ver_str in available_vers:
> -                        available_vers.append(ver_str)
> +            for f in pkg_pn:
> +                pe, pv, pr =3D dataCache.pkg_pepvpr[f]
> +                ver_str =3D pv
> +                if pe:
> +                    ver_str =3D "%s:%s" % (pe, ver_str)
> +                if not ver_str in available_vers:
> +                    available_vers.append(ver_str)
>              if available_vers:
>                  available_vers.sort()
>                  logger.warning("versions of %s available: %s", pn, '
> '.join(available_vers))
> @@ -226,7 +216,7 @@ def findBestProvider(pn, cfgData, dataCache, pkg_pn =
=3D
> None, item =3D None):
>      # Find the highest priority provider with a REQUIRED_VERSION or
> PREFERRED_VERSION set
>      (preferred_ver, preferred_file, required) =3D findPreferredProvider(=
pn,
> cfgData, dataCache, sortpkg_pn, item)
>      # Find the latest version of the highest priority provider
> -    (latest, latest_f) =3D findLatestProvider(pn, cfgData, dataCache,
> sortpkg_pn[0])
> +    (latest, latest_f) =3D findLatestProvider(pn, cfgData, dataCache,
> sortpkg_pn)
>
>      if not required and preferred_file is None:
>          preferred_file =3D latest_f
> @@ -272,7 +262,7 @@ def _filterProviders(providers, item, cfgData,
> dataCache):
>      for pn in sorted(sortpkg_pn):
>          if pn in preferred_versions and preferred_versions[pn][1]:
>              continue
> -        preferred_versions[pn] =3D findLatestProvider(pn, cfgData,
> dataCache, sortpkg_pn[pn][0])
> +        preferred_versions[pn] =3D findLatestProvider(pn, cfgData,
> dataCache, sortpkg_pn[pn])
>          eligible.append(preferred_versions[pn][1])
>
>      if not eligible:
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index 068b631c94..3ee3aa8875 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -1563,7 +1563,7 @@ def get_file_layer(filename, d, collection_res=3D{}=
):
>          return match
>
>      result =3D None
> -    bbfiles =3D (d.getVar('BBFILES_PRIORITIZED') or '').split()
> +    bbfiles =3D (d.getVar('BBFILES') or '').split()
>      bbfilesmatch =3D False
>      for bbfilesentry in bbfiles:
>          if fnmatch.fnmatchcase(filename, bbfilesentry):
> --
> 2.40.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15828):
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_g_bitbake-2Ddevel_message_15828&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4v=
CHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D-B=
k9X9Hkhx7e8xkBu1GuKqAlibTmXrlpwi04sRozJiDG2hny7t3LoP4wS7J5-J1X&s=3D_a531ues=
DcSw3cAizdlUN2ELeqExHwsmX8gPYd9A4M8&e=3D
> Mute This Topic:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_mt_104196430_7048771&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC=
2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D-Bk9X9Hkhx7e8=
xkBu1GuKqAlibTmXrlpwi04sRozJiDG2hny7t3LoP4wS7J5-J1X&s=3DI91ejppj2TYm8gaYh7r=
kXuF4MY5pjp0ygWa4N1-6_74&e=3D
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_g_bitbake-2Ddevel_unsub&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGk=
ICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D-Bk9X9Hkhx=
7e8xkBu1GuKqAlibTmXrlpwi04sRozJiDG2hny7t3LoP4wS7J5-J1X&s=3DhlSuw-Ye47nxphec=
CrzUytKlMvZ1ObQ1WK5hRj_dgb4&e=3D
> [ecordonnier@snap.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000864b990610b83445
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Richard, there is a word missing in the commit message:=
<br>&quot;=C2=A0The functionality had a and place&quot; -&gt; &quot;the fun=
ctionality had a time and place&quot;<br>Also a typo: &quot;comparibility&q=
uot; -&gt; &quot;=C2=A0compatibility=C2=A0&quot;<br><br>What is the correct=
 way to set layer priorities after this patch (I&#39;m asking because the B=
SP I&#39;m using makes use of BBFILE_PRIORITY)?<br><br>Etienne</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 6=
, 2024 at 1:15=E2=80=AFPM Richard Purdie &lt;<a href=3D"mailto:richard.purd=
ie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">These entries, us=
ually in layer.conf are part of an old, pre-layers<br>
part of bitbake for overlay/collection support. This is not really<br>
used any more and was replaced by the idea of layers.<br>
<br>
In a recent discussion, we asked the question &quot;When do you need to<br>
use proprities?&quot; and the answer was &quot;almost never&quot; given all=
 the other<br>
tools and techniques now available in layers.<br>
<br>
These layer priorities cause users huge amounts of confusion. It is<br>
unclear to people how the &quot;magic values&quot; work if it is unset<br>
and if they are set differently, users don&#39;t expect the way it<br>
actually works and the effects it has between layers.<br>
<br>
In discussions I&#39;ve had, there has been surprisingly strong support<br>
for removing them entirely, even if that does means we&#39;d need to fix<br=
>
some corner caes.<br>
<br>
I wholly agree and support that idea, so lets remove the support<br>
and take a simplification where we can. The functionality had a<br>
and place but it has passed and we&#39;ve moved on.<br>
<br>
Developers are about to need to change layer.conf to update the<br>
series comparibility for the next release so it is a good time to<br>
do it.<br>
<br>
This patch removes the core support and replaces it with a warning.<br>
It does not chase down every last reference or function parmeter,<br>
that can follow as time allows.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
---<br>
=C2=A0lib/bb/cache.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 1 -<br>
=C2=A0lib/bb/cooker.py=C2=A0 =C2=A0 | 51 +++++++---------------------------=
-----<br>
=C2=A0lib/bb/providers.py | 58 +++++++++++++++++++-------------------------=
-<br>
=C2=A0lib/bb/utils.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A04 files changed, 34 insertions(+), 78 deletions(-)<br>
<br>
diff --git a/lib/bb/cache.py b/lib/bb/cache.py<br>
index 18d5574a31..64dbffc0f6 100644<br>
--- a/lib/bb/cache.py<br>
+++ b/lib/bb/cache.py<br>
@@ -818,7 +818,6 @@ class CacheData(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Indirect Cache variables (set elsewhere=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ignored_dependencies =3D []<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.world_target =3D set()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.bbfile_priority =3D {}<br>
<br>
=C2=A0 =C2=A0 =C2=A0def add_from_recipeinfo(self, fn, info_array):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for info in info_array:<br>
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py<br>
index c5bfef55d6..381379086a 100644<br>
--- a/lib/bb/cooker.py<br>
+++ b/lib/bb/cooker.py<br>
@@ -1124,26 +1124,15 @@ class BBCooker:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errors =3D False<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.bbfile_config_priorities =3D []<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if collections:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 collection_priorities =3D {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0collection_depends =3D {}<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0collection_list =3D collect=
ions.split()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0min_prio =3D 0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for c in collection_list:<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.debug(1,&#=
39;Processing %s in collection list&#39; % (c))<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Get collection p=
riority if defined explicitly<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0priority =3D =
self.data.getVar(&quot;BBFILE_PRIORITY_%s&quot; % c)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if priority:<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 prio =3D int(priority)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exce=
pt ValueError:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 parselog.error(&quot;invalid value for BBFILE_PRIORITY_%s: \&quo=
t;%s\&quot;&quot;, c, priority)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 errors =3D True<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if m=
in_prio =3D=3D 0 or prio &lt; min_prio:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 min_prio =3D prio<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 coll=
ection_priorities[c] =3D prio<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 coll=
ection_priorities[c] =3D None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.w=
arn(&quot;Ignoring obsolete BBFILE_PRIORITY_%s&quot; % c)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Check depen=
dencies and store information for priority calculation<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0deps =3D self=
.data.getVar(&quot;LAYERDEPENDS_%s&quot; % c)<br>
@@ -1204,22 +1193,9 @@ class BBCooker:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parselog.debug3(&quot;Layer &#39;%s&#39; rec=
ommends layer &#39;%s&#39;, but this layer is not enabled in your configura=
tion&quot;, c, rec)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Recursively work out collectio=
n priorities based on dependencies<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 def calc_layer_priority(collecti=
on):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not collection_=
priorities[collection]:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max_=
depprio =3D min_prio<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for =
dep in collection_depends[collection]:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 calc_layer_priority(dep)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 depprio =3D collection_priorities[dep]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if depprio &gt; max_depprio:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 max_depprio =3D depprio<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max_=
depprio +=3D 1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pars=
elog.debug(&quot;Calculated priority of layer %s as %d&quot;, collection, m=
ax_depprio)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 coll=
ection_priorities[collection] =3D max_depprio<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Calculate all layer priorities=
 using calc_layer_priority and store in bbfile_config_priorities<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Store all layer priorities in =
bbfile_config_priorities<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for c in collection_list:<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 calc_layer_priorit=
y(c)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0regex =3D sel=
f.data.getVar(&quot;BBFILE_PATTERN_%s&quot; % c)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if regex is N=
one:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0parselog.error(&quot;BBFILE_PATTERN_%s not defined&quot; % c)<br>
@@ -1236,7 +1212,7 @@ class BBCooker:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0parselog.error(&quot;BBFILE_PATTERN_%s \&quot;%s\&quot; is=
 not a valid regular expression&quot;, c, regex)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0errors =3D True<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0continue<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.bbfile_config=
_priorities.append((c, regex, cre, collection_priorities[c]))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.bbfile_config=
_priorities.append((c, regex, cre, 0))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if errors:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# We&#39;ve already printed=
 the actual error(s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise CollectionError(&quot=
;Errors during parsing layer configuration&quot;)<br>
@@ -1358,7 +1334,6 @@ class BBCooker:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Tweak some variables<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0item =3D info_array[0].pn<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.recipecaches[mc].ignored_dependencie=
s =3D set()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.recipecaches[mc].bbfile_priority[fn] =3D =
1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.configuration.limited_deps =3D True<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Remove external dependencies<br>
@@ -1639,7 +1614,7 @@ class BBCooker:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.show_appends_with_no_r=
ecipes()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.handlePrefProviders()<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for mc in self.multiconfigs=
:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.recipecaches[=
mc].bbfile_priority =3D self.collections[mc].collection_priorities(self.rec=
ipecaches[mc].pkg_fn, self.parser.mcfilelist[mc], self.data)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.collections[m=
c].collection_priorities(self.recipecaches[mc].pkg_fn, self.parser.mcfileli=
st[mc], self.data)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.state =3D state.runnin=
g<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Send an event listing all=
 stamps reachable after parsing<br>
@@ -1767,9 +1742,9 @@ class CookerCollectFiles(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.bbfile_config_priorities =3D sorted(=
priorities, key=3Dlambda tup: tup[1], reverse=3DTrue)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def calc_bbfile_priority(self, filename):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for layername, _, regex, pri in self.bbfile_co=
nfig_priorities:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for layername, _, regex, _ in self.bbfile_conf=
ig_priorities:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if regex.match(filename):<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return pri, regex,=
 layername<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0, regex, l=
ayername<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0, None, None<br>
<br>
=C2=A0 =C2=A0 =C2=A0def get_bbfiles(self):<br>
@@ -1801,10 +1776,6 @@ class CookerCollectFiles(object):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0files =3D (config.getVar( &quot;BBFILES&q=
uot;) or &quot;&quot;).split()<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Sort files by priority<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 files.sort( key=3Dlambda fileitem: self.calc_b=
bfile_priority(fileitem)[0] )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 config.setVar(&quot;BBFILES_PRIORITIZED&quot;,=
 &quot; &quot;.join(files))<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not files:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0files =3D self.get_bbfiles(=
)<br>
<br>
@@ -1926,12 +1897,10 @@ class CookerCollectFiles(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return tuple(filelist)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def collection_priorities(self, pkgfns, fns, d):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Return the priorities of the entries in pkgf=
ns<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Also check that all the regexes in self.bbfi=
le_config_priorities are used<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Check that all the regexes in self.bbfile_co=
nfig_priorities are used<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# (but to do that we need to ensure skipp=
ed recipes aren&#39;t counted, nor<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# collections in BBFILE_PATTERN_IGNORE_EM=
PTY)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 priorities =3D {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0seen =3D set()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0matched =3D set()<br>
<br>
@@ -1943,7 +1912,7 @@ class CookerCollectFiles(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Calculate priorities for each file<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for p in pkgfns:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0realfn, cls, mc =3D bb.cach=
e.virtualfn2realfn(p)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 priorities[p], regex, _ =3D self=
.calc_bbfile_priority(realfn)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _, regex, _ =3D self.calc_bbfile=
_priority(realfn)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if regex in unmatched_regex=
:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0matched_regex=
.add(regex)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unmatched_reg=
ex.remove(regex)<br>
@@ -1985,8 +1954,6 @@ class CookerCollectFiles(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0collectlog.warning(&quot;No bb files in %s matched BBFILE_PATTERN_%s &#3=
9;%s&#39;&quot; % (<a href=3D"http://self.mc" rel=3D"noreferrer" target=3D"=
_blank">self.mc</a> if <a href=3D"http://self.mc" rel=3D"noreferrer" target=
=3D"_blank">self.mc</a> else &#39;default&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 collection, pattern))<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return priorities<br>
-<br>
=C2=A0class ParsingFailure(Exception):<br>
=C2=A0 =C2=A0 =C2=A0def __init__(self, realexception, recipe):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.realexception =3D realexception<br>
diff --git a/lib/bb/providers.py b/lib/bb/providers.py<br>
index e11a4637d1..f527dc469f 100644<br>
--- a/lib/bb/providers.py<br>
+++ b/lib/bb/providers.py<br>
@@ -71,21 +71,15 @@ def sortPriorities(pn, dataCache, pkg_pn =3D None):<br>
=C2=A0 =C2=A0 =C2=A0files =3D pkg_pn[pn]<br>
=C2=A0 =C2=A0 =C2=A0priorities =3D {}<br>
=C2=A0 =C2=A0 =C2=A0for f in files:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 priority =3D dataCache.bbfile_priority[f]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0preference =3D dataCache.pkg_dp[f]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if priority not in priorities:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 priorities[priority] =3D {}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if preference not in priorities[priority]:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 priorities[priority][preference]=
 =3D []<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 priorities[priority][preference].append(f)<br>
-=C2=A0 =C2=A0 tmp_pn =3D []<br>
-=C2=A0 =C2=A0 for pri in sorted(priorities):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp_pref =3D []<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for pref in sorted(priorities[pri]):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp_pref.extend(priorities[pri][=
pref])<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp_pn =3D [tmp_pref] + tmp_pn<br>
-<br>
-=C2=A0 =C2=A0 return tmp_pn<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if preference not in priorities:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 priorities[preference] =3D []<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 priorities[preference].append(f)<br>
+=C2=A0 =C2=A0 tmp_pref =3D []<br>
+=C2=A0 =C2=A0 for pref in sorted(priorities):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp_pref.extend(priorities[pref])<br>
+<br>
+=C2=A0 =C2=A0 return tmp_pref<br>
<br>
=C2=A0def versionVariableMatch(cfgData, keyword, pn):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
@@ -115,7 +109,7 @@ def preferredVersionMatch(pe, pv, pr, preferred_e, pref=
erred_v, preferred_r):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return True<b=
r>
=C2=A0 =C2=A0 =C2=A0return False<br>
<br>
-def findPreferredProvider(pn, cfgData, dataCache, pkg_pn =3D None, item =
=3D None):<br>
+def findPreferredProvider(pn, cfgData, dataCache, pkg_pn, item):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0Find the first provider in pkg_pn with REQUIRED_VERSION=
 or PREFERRED_VERSION set.<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
@@ -156,15 +150,12 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg=
_pn =3D None, item =3D None):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0preferred_e =3D None<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0preferred_r =3D None<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for file_set in pkg_pn:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for f in file_set:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pe, pv, pr =3D dat=
aCache.pkg_pepvpr[f]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if preferredVersio=
nMatch(pe, pv, pr, preferred_e, preferred_v, preferred_r):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pref=
erred_file =3D f<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pref=
erred_ver =3D (pe, pv, pr)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brea=
k<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if preferred_file:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for f in pkg_pn:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pe, pv, pr =3D dataCache.pkg_pep=
vpr[f]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if preferredVersionMatch(pe, pv,=
 pr, preferred_e, preferred_v, preferred_r):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 preferred_file =3D=
 f<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 preferred_ver =3D =
(pe, pv, pr)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if preferred_r:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pv_str =3D &#39;%s-%s&#39; =
% (preferred_v, preferred_r)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
@@ -175,14 +166,13 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg=
_pn =3D None, item =3D None):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not required:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.warnin=
g(&quot;preferred version %s of %s not available%s&quot;, pv_str, pn, items=
tr)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0available_vers =3D []<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for file_set in pkg_pn:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for f in file_set:=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pe, =
pv, pr =3D dataCache.pkg_pepvpr[f]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ver_=
str =3D pv<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if p=
e:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ver_str =3D &quot;%s:%s&quot; % (pe, ver_str)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if n=
ot ver_str in available_vers:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 available_vers.append(ver_str)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for f in pkg_pn:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pe, pv, pr =3D dat=
aCache.pkg_pepvpr[f]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ver_str =3D pv<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if pe:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ver_=
str =3D &quot;%s:%s&quot; % (pe, ver_str)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not ver_str in =
available_vers:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 avai=
lable_vers.append(ver_str)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if available_vers:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0available_ver=
s.sort()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.warnin=
g(&quot;versions of %s available: %s&quot;, pn, &#39; &#39;.join(available_=
vers))<br>
@@ -226,7 +216,7 @@ def findBestProvider(pn, cfgData, dataCache, pkg_pn =3D=
 None, item =3D None):<br>
=C2=A0 =C2=A0 =C2=A0# Find the highest priority provider with a REQUIRED_VE=
RSION or PREFERRED_VERSION set<br>
=C2=A0 =C2=A0 =C2=A0(preferred_ver, preferred_file, required) =3D findPrefe=
rredProvider(pn, cfgData, dataCache, sortpkg_pn, item)<br>
=C2=A0 =C2=A0 =C2=A0# Find the latest version of the highest priority provi=
der<br>
-=C2=A0 =C2=A0 (latest, latest_f) =3D findLatestProvider(pn, cfgData, dataC=
ache, sortpkg_pn[0])<br>
+=C2=A0 =C2=A0 (latest, latest_f) =3D findLatestProvider(pn, cfgData, dataC=
ache, sortpkg_pn)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if not required and preferred_file is None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0preferred_file =3D latest_f<br>
@@ -272,7 +262,7 @@ def _filterProviders(providers, item, cfgData, dataCach=
e):<br>
=C2=A0 =C2=A0 =C2=A0for pn in sorted(sortpkg_pn):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if pn in preferred_versions and preferred=
_versions[pn][1]:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 preferred_versions[pn] =3D findLatestProvider(=
pn, cfgData, dataCache, sortpkg_pn[pn][0])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 preferred_versions[pn] =3D findLatestProvider(=
pn, cfgData, dataCache, sortpkg_pn[pn])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0eligible.append(preferred_versions[pn][1]=
)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if not eligible:<br>
diff --git a/lib/bb/utils.py b/lib/bb/utils.py<br>
index 068b631c94..3ee3aa8875 100644<br>
--- a/lib/bb/utils.py<br>
+++ b/lib/bb/utils.py<br>
@@ -1563,7 +1563,7 @@ def get_file_layer(filename, d, collection_res=3D{}):=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return match<br>
<br>
=C2=A0 =C2=A0 =C2=A0result =3D None<br>
-=C2=A0 =C2=A0 bbfiles =3D (d.getVar(&#39;BBFILES_PRIORITIZED&#39;) or &#39=
;&#39;).split()<br>
+=C2=A0 =C2=A0 bbfiles =3D (d.getVar(&#39;BBFILES&#39;) or &#39;&#39;).spli=
t()<br>
=C2=A0 =C2=A0 =C2=A0bbfilesmatch =3D False<br>
=C2=A0 =C2=A0 =C2=A0for bbfilesentry in bbfiles:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if fnmatch.fnmatchcase(filename, bbfilese=
ntry):<br>
-- <br>
2.40.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15828): <a href=3D"https://urldefense.proofpoint.com/v2=
/url?u=3Dhttps-3A__lists.openembedded.org_g_bitbake-2Ddevel_message_15828&a=
mp;d=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DA=
hkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D-Bk9X9Hkhx7e8xkBu1GuKqAl=
ibTmXrlpwi04sRozJiDG2hny7t3LoP4wS7J5-J1X&amp;s=3D_a531uesDcSw3cAizdlUN2ELeq=
ExHwsmX8gPYd9A4M8&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://ur=
ldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded.org_g_bitba=
ke-2Ddevel_message_15828&amp;d=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHva=
bgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=
=3D-Bk9X9Hkhx7e8xkBu1GuKqAlibTmXrlpwi04sRozJiDG2hny7t3LoP4wS7J5-J1X&amp;s=
=3D_a531uesDcSw3cAizdlUN2ELeqExHwsmX8gPYd9A4M8&amp;e=3D</a> <br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.openembedded.org_mt_104196430_7048771&amp;d=3DDwIFaQ&amp;c=3D=
ncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&amp;m=3D-Bk9X9Hkhx7e8xkBu1GuKqAlibTmXrlpwi04sRozJiDG2h=
ny7t3LoP4wS7J5-J1X&amp;s=3DI91ejppj2TYm8gaYh7rkXuF4MY5pjp0ygWa4N1-6_74&amp;=
e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__lists.openembedded.org_mt_104196430_7048771&amp;d=3D=
DwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonV=
uMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D-Bk9X9Hkhx7e8xkBu1GuKqAlibTmXrl=
pwi04sRozJiDG2hny7t3LoP4wS7J5-J1X&amp;s=3DI91ejppj2TYm8gaYh7rkXuF4MY5pjp0yg=
Wa4N1-6_74&amp;e=3D</a> <br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.openembedded.org_g_bitbake-2Ddevel_unsub&amp;d=3DDwIFaQ&amp;c=3Dn=
cDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&amp;m=3D-Bk9X9Hkhx7e8xkBu1GuKqAlibTmXrlpwi04sRozJiDG2hn=
y7t3LoP4wS7J5-J1X&amp;s=3DhlSuw-Ye47nxphecCrzUytKlMvZ1ObQ1WK5hRj_dgb4&amp;e=
=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.com=
/v2/url?u=3Dhttps-3A__lists.openembedded.org_g_bitbake-2Ddevel_unsub&amp;d=
=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbN=
onVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D-Bk9X9Hkhx7e8xkBu1GuKqAlibTm=
Xrlpwi04sRozJiDG2hny7t3LoP4wS7J5-J1X&amp;s=3DhlSuw-Ye47nxphecCrzUytKlMvZ1Ob=
Q1WK5hRj_dgb4&amp;e=3D</a>=C2=A0 [<a href=3D"mailto:ecordonnier@snap.com" t=
arget=3D"_blank">ecordonnier@snap.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000864b990610b83445--

