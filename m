Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763B7C77B73
	for <webhook@archiver.kernel.org>; Thu, 27 Apr 2023 03:49:30 +0000 (UTC)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
 by mx.groups.io with SMTP id smtpd.web11.12530.1682567369309726700
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Apr 2023 20:49:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=RVcSjDNV;
 spf=pass (domain: gmail.com, ip: 209.85.160.52, mailfrom: raj.khem@gmail.com)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1879e28ab04so6416255fac.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 26 Apr 2023 20:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682567368; x=1685159368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7pC+YmvnvceUqUfBR0tJ13jSHlgdZeM+KXkC5wwlog=;
        b=RVcSjDNV2rtz4PK3fAcoeNWoIRUdO6sHwaKPuCYjB0rjJIQPc6KtIdrhd6bFg/dG/s
         tliXQX8dqFNvqDIJ4JzV/BInokrrmse9TvGSv67b57cj0lowdzNVE5lb6xdExtfcrSQm
         1tHBWqTOmg2kUcEo/khxkMRFKc1FZYFgFGnlsL38iB/EjonEqXevXnf3PkjCd/MYDnEV
         1yIXt81No4PdtzAMY7PrHg2n/YswyuOga43RMJ9+fbgp0ftf7kiIVOHhpITgwWa7WzQg
         BHkqmJyBmkYnA6iJ9LCw3mZZ+r/9KFLCncJ7XahnZ0pzUP7M7mzg8yq4OiiQUoClUIXj
         RZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682567368; x=1685159368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7pC+YmvnvceUqUfBR0tJ13jSHlgdZeM+KXkC5wwlog=;
        b=UEhsYRoqQZI7Ce6cHbLyfb7SMiqf9BV9BNIrJwyL+rETkRda7XSIX8HpAwYCqo4udS
         tDiSf2iBXrTJZR9O+YLdtdlmHkXo2iQReRu2vYLHMUQ91woIfjSk7PufSZFJyZo453nr
         xz5Qg6bdEd9x9gZB7sWEWxEu2Y9yYdNVca/Arg97B6pXyRTCYxCG8VI9PEL3AeyCbJ+b
         vxcRZFy8MGOXesIQCurCAa1VAzyNNJF/EJ1zg5zte/3jx0SY1avTjtj2jbeQrQ/ABFFy
         V0AAfe5SfOxc3QeCOy3K5v1snp55aFP8xYHfNE3uNzFVaasAM4ooK7lRVfLE5hm7/GKc
         l3ow==
X-Gm-Message-State: AC+VfDxztiFqAGmW8MH/j9MRnmctI7GbO8XqRzZX1t9aE0s+CfgBYPse
	4fYw7Ho+6IkJsbmMMsieKo8Jb8NckUeJhEeWjVE=
X-Google-Smtp-Source: ACHHUZ7vqI6AXjFciPUfZ/CiGRgtrce8ARyPAO2mXu2dF/ypmaIxOH1h2wZrA8ik2Eqj1MKyif2zONuS9HRP/HjQbeU=
X-Received: by 2002:a05:6808:618d:b0:38d:e13b:9af with SMTP id
 dn13-20020a056808618d00b0038de13b09afmr58007oib.28.1682567368131; Wed, 26 Apr
 2023 20:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230420062113.134546-1-alberto@pianon.eu>
In-Reply-To: <20230420062113.134546-1-alberto@pianon.eu>
From: Khem Raj <raj.khem@gmail.com>
Date: Wed, 26 Apr 2023 20:49:02 -0700
Message-ID: <CAMKF1sre46PCJrhPcuHzYu8_uLHabY4S_+up5vwvyWnjmSeooA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] upstream source tracing: data collection
 (patch 2/3)
To: Alberto Pianon <alberto@pianon.eu>
Cc: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org, 
	jpewhacker@gmail.com, carlo@piana.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Apr 2023 03:49:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14747

this patch is emitting diagnostics on bitbake invocation which I dont
understand. It seems unnecessary distraction on cmdline. if this is
expected warning then how do we fix
the code to quash it ?

WARNING: matchbox-panel-2-2.12-r0 do_unpack: Can't find upstream
source for /mnt/b/yoe/master/sources/poky/meta/recipes-sato/m
atchbox-panel-2/files/0001-applets-systray-Allow-icons-to-be-smaller.patch,
using file://<local-path>/meta/recipes-sato/matchb
ox-panel-2/files/0001-applets-systray-Allow-icons-to-be-smaller.patch
as download location
WARNING: matchbox-keyboard-0.1.1-r0 do_unpack: Can't find upstream
source for /mnt/b/yoe/master/sources/poky/meta/recipes-sato
/matchbox-keyboard/files/0001-desktop-file-Hide-the-keyboard-from-app-list.=
patch,
using file://<local-path>/meta/recipes-sato/
matchbox-keyboard/files/0001-desktop-file-Hide-the-keyboard-from-app-list.p=
atch
as download location
WARNING: matchbox-keyboard-0.1.1-r0 do_unpack: Can't find upstream
source for /mnt/b/yoe/master/sources/poky/meta/recipes-sato
/matchbox-keyboard/files/80matchboxkeyboard.sh, using
file://<local-path>/meta/recipes-sato/matchbox-keyboard/files/80matchbox
keyboard.sh as download location

On Wed, Apr 19, 2023 at 11:21=E2=80=AFPM Alberto Pianon <alberto@pianon.eu>=
 wrote:
>
> From: Alberto Pianon <alberto@pianon.eu>
>
> License compliance, SBoM generation and CVE checking require to be able
> to trace each source file back to its corresponding upstream source. The
> current implementation of bb.fetch2 makes it difficult, especially when
> multiple sources are combined together.
>
> This series of patches provides a solution to the issue by implementing
> a process that unpacks each SRC_URI element into a temporary directory,
> collects relevant provenance metadata on each source file, moves
> everything to the recipe rootdir, and saves metadata in a JSON file.
>
> The proposed solution is split into a series of patches, with the first
> patch containing required modifications to fetchers' code and a
> TraceUnpackBase class that implements the process, and the second patch
> implementing the data collecting logic in a separate TraceUnpack
> subclass. The final patch includes test data and test cases to
> demonstrate the solution's efficacy.
>
> Signed-off-by: Alberto Pianon <alberto@pianon.eu>
> ---
>  lib/bb/fetch2/trace.py | 552 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 552 insertions(+)
>  create mode 100644 lib/bb/fetch2/trace.py
>
> diff --git a/lib/bb/fetch2/trace.py b/lib/bb/fetch2/trace.py
> new file mode 100644
> index 00000000..76f08488
> --- /dev/null
> +++ b/lib/bb/fetch2/trace.py
> @@ -0,0 +1,552 @@
> +"""
> +Module implementing upstream source tracing process for do_unpack.
> +
> +For the general process design, see .trace_base module help texts.
> +
> +The final output is a compressed json file, stored in <workdir>/temp for
> +each recipe, with the following scheme:
> +
> +{
> +    "<download location>": {
> +        "download_location": "<download location>",
> +        "src_uri": "<src_uri>",
> +        "unexpanded_src_uri": "<unexpanded src uri>",
> +        "checksums": {
> +            "md5": "<package md5 checksum>",
> +            "sha256": "<package sha256 checksum>"
> +        },
> +        "files": {
> +            "<file/relpath/in/upstream>": {
> +                "sha1": "<file sha1 checksum>",
> +                "paths_in_workdir": [
> +                    "<file/relpath//in/workdir>",
> +                    "<other/file/relpath/in/workdir>"
> +                ]
> +            }
> +        }
> +    }
> +}
> +
> +NOTE: "download location" is used as main key/index and follows SPDX spe=
cs, eg.:
> +https://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz
> +git+git://sourceware.org/git/bzip2-tests.git@f9061c030a25de5b6829e1abf37=
3057309c734c0:
> +
> +Special cases:
> +
> +- npmsw and gitsm fetchers generate and unpack multiple uris (one for th=
e main
> +  git repo (gitsm) or for the npm-shrinkwrap.json file (npmsw), and one =
for each
> +  (sub)module) from a single SRC_URI entry; each of such uris is represe=
nted by
> +  a separate download location in the json file, while they will all sha=
re the
> +  same SRC_URI entry
> +
> +- npmsw and gitsm fetchers collect also internal dependency information,=
 which
> +  are stored as a list of parent module download locations in the
> +  "dependency_of" property for each download location
> +
> +- file:// SRC_URI entries are mapped each to a single download location,
> +  and file's path in upstream sources is put directly in the download
> +  location, in this way:
> +  git+git://git.yoctoproject.org/poky@91d0157d6daf4ea61d6b4e090c0b682d3f=
3ca60f#meta/recipes-extended/bzip2/bzip2/Makefile.am
> +  In such case, the "<file/relpath/in/upstream>" key will be an empty st=
ring "".
> +  The latter does not hold for file:// SRC_URI pointing to a directory o=
r to an
> +  archive; in such cases, "<file/relpath/in/upstream>" will be relative =
to the
> +  directory or to the archive
> +
> +- if no download location is found for a file:// SRC_URI entry, a warnin=
g is
> +  logged and an "invalid" local download location is used, trying to map=
 it at least to an existing local bblayer, if any
> +
> +- local absolute paths found SRC_URI entries are replaced by a placehold=
er
> +  ("<local-path>"), to allow reproducibility of json results, while the
> +  corresponding unexpanded SRC_URI entry is also stored to allow to trac=
e it
> +  back to the corresponding recipe
> +
> +For more details and handled corner cases, see help texts in
> +bb.tests.trace.TraceUnpackIntegrationTest and real-world data examples i=
n
> +lib/bb/tests/trace-testdata.
> +"""
> +
> +# Copyright (C) 2023 Alberto Pianon <pianon@array.eu>
> +#
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +
> +import os
> +import re
> +import logging
> +
> +import bb.fetch2
> +import bb.utils
> +import bb.process
> +
> +from .trace_base import TraceUnpackBase, TraceException
> +
> +logger =3D logging.getLogger("BitBake.Fetcher")
> +
> +# function copied from https://git.openembedded.org/openembedded-core/pl=
ain/meta/lib/oe/recipeutils.py?id=3Dad3736d9ca14cac14a7da22c1cfdeda219665e6=
f
> +# Copyright (C) 2013-2017 Intel Corporation
> +def split_var_value(value, assignment=3DTrue):
> +    """
> +    Split a space-separated variable's value into a list of items,
> +    taking into account that some of the items might be made up of
> +    expressions containing spaces that should not be split.
> +    Parameters:
> +        value:
> +            The string value to split
> +        assignment:
> +            True to assume that the value represents an assignment
> +            statement, False otherwise. If True, and an assignment
> +            statement is passed in the first item in
> +            the returned list will be the part of the assignment
> +            statement up to and including the opening quote character,
> +            and the last item will be the closing quote.
> +    """
> +    inexpr =3D 0
> +    lastchar =3D None
> +    out =3D []
> +    buf =3D ''
> +    for char in value:
> +        if char =3D=3D '{':
> +            if lastchar =3D=3D '$':
> +                inexpr +=3D 1
> +        elif char =3D=3D '}':
> +            inexpr -=3D 1
> +        elif assignment and char in '"\'' and inexpr =3D=3D 0:
> +            if buf:
> +                out.append(buf)
> +            out.append(char)
> +            char =3D ''
> +            buf =3D ''
> +        elif char.isspace() and inexpr =3D=3D 0:
> +            char =3D ''
> +            if buf:
> +                out.append(buf)
> +            buf =3D ''
> +        buf +=3D char
> +        lastchar =3D char
> +    if buf:
> +        out.append(buf)
> +
> +    # Join together assignment statement and opening quote
> +    outlist =3D out
> +    if assignment:
> +        assigfound =3D False
> +        for idx, item in enumerate(out):
> +            if '=3D' in item:
> +                assigfound =3D True
> +            if assigfound:
> +                if '"' in item or "'" in item:
> +                    outlist =3D [' '.join(out[:idx+1])]
> +                    outlist.extend(out[idx+1:])
> +                    break
> +    return outlist
> +
> +def get_unexp_src_uri(src_uri, d):
> +    """get unexpanded src_uri"""
> +    src_uris =3D d.getVar("SRC_URI").split() if d.getVar("SRC_URI") else=
 []
> +    if src_uri not in src_uris:
> +        raise TraceException("%s does not exist in d.getVar('SRC_URI')" =
% src_uri)
> +    unexp_src_uris =3D split_var_value(
> +        d.getVar("SRC_URI", expand=3DFalse), assignment=3DFalse)
> +    for unexp_src_uri in unexp_src_uris:
> +        if src_uri in d.expand(unexp_src_uri).split():
> +            # some unexpanded src_uri with expressions may expand to mul=
tiple
> +            # lines/src_uris
> +            return unexp_src_uri
> +    return src_uri
> +
> +find_abs_path_regex =3D [
> +    r"(?<=3D://)/[^;]+$",     # url path (as in file:/// or npmsw:///)
> +    r"(?<=3D://)/[^;]+(?=3D;)", # url path followed by param
> +    r"(?<=3D=3D)/[^;]+$",       # path in param
> +    r"(?<=3D=3D)/[^;]+(?=3D;)",   # path in param followed by another pa=
ram
> +]
> +find_abs_path_regex =3D [ re.compile(r) for r in find_abs_path_regex ]
> +
> +def get_clean_src_uri(src_uri):
> +    """clean expanded src_uri from possible local absolute paths"""
> +    for r in find_abs_path_regex:
> +        src_uri =3D r.sub("<local-path>", src_uri)
> +    return src_uri
> +
> +def blame_recipe_file(unexp_src_uri, d):
> +    """return the .bb|.inc|.bbappend  file(s) which set or appended the =
given
> +    unexpanded src_uri element. Var history tracking must be enabled for=
 this
> +    to work."""
> +    # NOTE this function is not being used for now
> +    haystack =3D []
> +    for el in d.varhistory.variable("SRC_URI"):
> +        if not el.get("parsing"):
> +            continue
> +        if el["op"] =3D=3D "set":
> +            haystack =3D [ el ]
> +        elif "append" in el["op"] or "prepend" in el["op"]:
> +            haystack.append(el)
> +    recipe_file =3D [
> +        el["file"] for el in haystack if unexp_src_uri in el["detail"].s=
plit()
> +    ]
> +    return recipe_file[-1] if recipe_file else None
> +
> +def get_dl_loc(local_dir):
> +    """get git upstream download location and relpath in git repo for lo=
cal_dir"""
> +    # copied and adapted from https://git.yoctoproject.org/poky-contrib/=
commit/?h=3Djpew/spdx-downloads&id=3D68c80f53e8c4f5fd2548773b450716a8027d18=
22
> +    # download location cache is implemented in TraceUnpack class
> +
> +    local_dir =3D os.path.realpath(local_dir)
> +    try:
> +        stdout, _ =3D bb.process.run(
> +            ["git", "branch", "-qr", "--format=3D%(refname)", "--contain=
s", "HEAD"],
> +            cwd=3Dlocal_dir
> +        )
> +        branches =3D stdout.splitlines()
> +        branches.sort()
> +        for b in branches:
> +            if b.startswith("refs/remotes") and not b.startswith("refs/r=
emotes/m/"):
> +                # refs/remotes/m/ -> repo manifest remote, it's not a re=
al
> +                # remote (see https://stackoverflow.com/a/63483426)
> +                remote =3D b.split("/")[2]
> +                break
> +        else:
> +            return None, None
> +
> +        stdout, _ =3D bb.process.run(
> +            ["git", "remote", "get-url", remote], cwd=3Dlocal_dir
> +        )
> +        dl_loc =3D "git+" + stdout.strip()
> +
> +        stdout, _ =3D bb.process.run(["git", "rev-parse", "HEAD"], cwd=
=3Dlocal_dir)
> +        dl_loc =3D dl_loc + "@" + stdout.strip()
> +
> +        stdout, _ =3D bb.process.run(
> +            ["git", "rev-parse", "--show-prefix"], cwd=3Dlocal_dir)
> +        relpath =3D os.path.join(stdout.strip().rstrip("/"))
> +
> +        return dl_loc, relpath
> +
> +    except bb.process.ExecutionError:
> +        return None, None
> +
> +def get_new_and_modified_files(git_dir):
> +    """get list of untracked or uncommitted new or modified files in git=
_dir"""
> +    try:
> +        bb.process.run(
> +            ["git", "rev-parse", "--is-inside-work-tree"], cwd=3Dgit_dir=
)
> +    except bb.process.ExecutionError:
> +        raise TraceException("%s is not a git repo" % git_dir)
> +    stdout, _ =3D bb.process.run(["git", "status", "--porcelain"], cwd=
=3Dgit_dir)
> +    return [ line[3:] for line in stdout.rstrip().split("\n") ]
> +
> +def get_path_in_upstream(f, u, ud, destdir):
> +    """get relative path in upstream package, relative to download locat=
ion"""
> +    relpath =3D os.path.relpath(f, destdir)
> +    if ud.type =3D=3D "file":
> +        is_unpacked_archive =3D getattr(ud, "is_unpacked_archive", False=
)
> +        if os.path.isdir(ud.localpath) or is_unpacked_archive:
> +            return os.path.relpath(relpath, ud.path)
> +        else:
> +            # it's a file, its path is already in download location, lik=
e
> +            # in git+https://git.example.com/foo#example/foo.c so there =
is
> +            # no relative path to download location
> +            return ""
> +    elif ud.type =3D=3D "npmsw" and ud.url =3D=3D u:
> +        # npm shrinkwrap file
> +        return ""
> +    else:
> +        return relpath
> +
> +def get_param(param, uri):
> +    """get parameter value from uri string"""
> +    match =3D re.search("(?<=3D;%s=3D)[^;]+" % param, uri)
> +    if match:
> +        return match[0]
> +    return None
> +
> +class TraceUnpack(TraceUnpackBase):
> +    """implement a process for upstream source tracing in do_unpack
> +
> +    Subclass of TraceUnpackBase, implementing _collect_data() and
> +    _process_data() methods
> +
> +    See bb.trace.unpack_base module help for more details on the process=
.
> +
> +    See bb.tests.trace.TraceUnpackIntegrationTest and data examples in
> +    lib/bb/tests/trace-testdata for details on the output json data form=
at.
> +
> +    Method call order:
> +        1. __init__()
> +        2. commit()
> +        3. move2root()
> +        4. write_data()
> +        5. close()
> +
> +    Steps 2-3 need to be called for every unpacked src uri
> +    """
> +
> +    def __init__(self, root, d):
> +        """create temporary directory in root, and initialize cache"""
> +        super(TraceUnpack, self).__init__(root, d)
> +
> +        self.local_path_cache =3D {}
> +        self.src_uri_cache =3D {}
> +        self.upstr_data_cache =3D {}
> +        self.package_checksums_cache =3D {}
> +        self.git_dir_cache =3D {}
> +        if d.getVar('BBLAYERS'):
> +            self.layers =3D {
> +                os.path.basename(l): os.path.realpath(l)
> +                for l in d.getVar('BBLAYERS').split()
> +            }
> +        else:
> +            self.layers =3D {}
> +
> +    def close(self):
> +        super(TraceUnpack, self).close()
> +        del self.local_path_cache
> +        del self.src_uri_cache
> +        del self.upstr_data_cache
> +        del self.package_checksums_cache
> +        del self.layers
> +
> +    def _get_layer(self, local_path):
> +        """get bb layer for local_path (must be a realpath)"""
> +        for layer, layer_path in self.layers.items():
> +            if local_path.startswith(layer_path):
> +                return layer
> +        return None
> +
> +    def _is_in_current_branch(self, file_relpath, git_dir):
> +        """wrapper for get_new_and_modified_files(), using cache
> +        for already processed git dirs"""
> +        if git_dir not in self.git_dir_cache:
> +            self.git_dir_cache[git_dir] =3D get_new_and_modified_files(g=
it_dir)
> +        new_and_modified_files =3D self.git_dir_cache[git_dir]
> +        return file_relpath not in new_and_modified_files
> +
> +    def _get_dl_loc_and_layer(self, local_path):
> +        """get downl. location, upstream relative path and layer for loc=
al_path
> +
> +        Wrapper for get_dl_loc() and TraceUnpack._get_layer(), using cac=
he for
> +        already processed local paths, and handling also file local path=
s and
> +        not only dirs.
> +        """
> +        local_path =3D os.path.realpath(local_path)
> +        if local_path not in self.local_path_cache:
> +            if os.path.isdir(local_path):
> +                dl_loc, relpath =3D get_dl_loc(local_path)
> +                layer =3D self._get_layer(local_path)
> +                self.local_path_cache[local_path] =3D (dl_loc, relpath, =
layer)
> +            else:
> +                local_dir, basename =3D os.path.split(local_path)
> +                dl_loc, dir_relpath, layer =3D self._get_dl_loc_and_laye=
r(local_dir)
> +                file_relpath =3D os.path.join(dir_relpath, basename) if =
dir_relpath else None
> +                if file_relpath:
> +                    if local_path.endswith(file_relpath):
> +                        git_dir =3D local_path[:-(len(file_relpath))].rs=
trip("/")
> +                    else:
> +                        raise TraceException(
> +                            "relative path %s is not in %s" %
> +                            (file_relpath, local_path)
> +                        )
> +                    if not self._is_in_current_branch(file_relpath, git_=
dir):
> +                        # it's an untracked|new|modified file in the git=
 repo,
> +                        # so it does not come from a known source
> +                        dl_loc =3D file_relpath =3D None
> +                self.local_path_cache[local_path] =3D (dl_loc, file_relp=
ath, layer)
> +        return self.local_path_cache[local_path]
> +
> +    def _get_unexp_and_clean_src_uri(self, src_uri):
> +        """get unexpanded and clean (i.e. w/o local paths) expanded src =
uri
> +
> +        Wrapper for get_unexp_src_uri() and clean_src_uri(), using cache=
 for
> +        already processed src uris
> +        """
> +        if src_uri not in self.src_uri_cache:
> +            try:
> +                unexp_src_uri =3D get_unexp_src_uri(src_uri, self.d)
> +            except TraceException:
> +                unexp_src_uri =3D src_uri
> +            clean_src_uri =3D get_clean_src_uri(src_uri)
> +            self.src_uri_cache[src_uri] =3D (unexp_src_uri, clean_src_ur=
i)
> +        return self.src_uri_cache[src_uri]
> +
> +    def _get_package_checksums(self, ud):
> +        """get package checksums for ud.url"""
> +        if ud.url not in self.package_checksums_cache:
> +            checksums =3D {}
> +            if ud.method.supports_checksum(ud):
> +                for checksum_id in bb.fetch2.CHECKSUM_LIST:
> +                    expected_checksum =3D getattr(ud, "%s_expected" % ch=
ecksum_id)
> +                    if expected_checksum is None:
> +                        continue
> +                    checksums.update({checksum_id: expected_checksum})
> +            self.package_checksums_cache[ud.url] =3D checksums
> +        return self.package_checksums_cache[ud.url]
> +
> +    def _get_upstr_data(self, src_uri, ud, local_path, revision):
> +        """get upstream data for src_uri
> +
> +        ud is required for non-file src_uris, while local_path is requir=
ed for
> +        file src_uris; revision is required for git submodule src_uris
> +        """
> +        if local_path:
> +            # file src_uri
> +            dl_loc, relpath, layer =3D self._get_dl_loc_and_layer(local_=
path)
> +            if dl_loc:
> +                dl_loc +=3D "#" + relpath
> +            else:
> +                # we didn't find any download location so we set a fake =
(but
> +                # unique) one because we need to use it as key in the fi=
nal json
> +                # output
> +                if layer:
> +                    relpath_in_layer =3D os.path.relpath(
> +                        os.path.realpath(local_path), self.layers[layer]=
)
> +                    dl_loc =3D "file://<local-path>/" + layer + "/" + re=
lpath_in_layer
> +                else:
> +                    dl_loc =3D "file://" + local_path
> +                    relpath =3D ""
> +                logger.warning(
> +                    "Can't find upstream source for %s, using %s as down=
load location" %
> +                    (local_path, dl_loc)
> +                )
> +            get_checksums =3D False
> +        else:
> +            # copied and adapted from https://git.yoctoproject.org/poky/=
plain/meta/classes/create-spdx-2.2.bbclass
> +            if ud.type =3D=3D "crate":
> +                # crate fetcher converts crate:// urls to https://
> +                this_ud =3D bb.fetch2.FetchData(ud.url, self.d)
> +            elif src_uri !=3D ud.url:
> +                # npmsw or gitsm module (src_uri !=3D ud.url)
> +                if ud.type =3D=3D "gitsm" and revision:
> +                    ld =3D self.d.createCopy()
> +                    name =3D get_param("name", src_uri)
> +                    v =3D ("SRCREV_%s" % name) if name else "SRCREV"
> +                    ld.setVar(v, revision)
> +                else:
> +                    ld =3D self.d
> +                this_ud =3D bb.fetch2.FetchData(src_uri, ld)
> +            else:
> +                this_ud =3D ud
> +            dl_loc =3D this_ud.type
> +            if dl_loc =3D=3D "gitsm":
> +                dl_loc =3D "git"
> +            proto =3D getattr(this_ud, "proto", None)
> +            if proto is not None:
> +                dl_loc =3D dl_loc + "+" + proto
> +            dl_loc =3D dl_loc + "://" + this_ud.host + this_ud.path
> +            if revision:
> +                dl_loc =3D dl_loc + "@" + revision
> +            elif this_ud.method.supports_srcrev():
> +                dl_loc =3D dl_loc + "@" + this_ud.revisions[this_ud.name=
s[0]]
> +            layer =3D None
> +            get_checksums =3D True
> +        if dl_loc not in self.upstr_data_cache:
> +            self.upstr_data_cache[dl_loc] =3D {
> +                "download_location": dl_loc,
> +            }
> +            uri =3D ud.url if ud.type in ["gitsm", "npmsw"] else src_uri
> +            unexp_src_uri, clean_src_uri =3D self._get_unexp_and_clean_s=
rc_uri(uri)
> +            self.upstr_data_cache[dl_loc].update({
> +                "src_uri": clean_src_uri
> +            })
> +            if unexp_src_uri !=3D clean_src_uri:
> +                self.upstr_data_cache[dl_loc].update({
> +                    "unexpanded_src_uri": unexp_src_uri
> +                })
> +            if get_checksums:
> +                checksums =3D self._get_package_checksums(ud or this_ud)
> +                if checksums:
> +                    self.upstr_data_cache[dl_loc].update({
> +                        "checksums": checksums
> +                    })
> +            if layer:
> +                self.upstr_data_cache[dl_loc].update({
> +                    "layer": layer
> +                })
> +        return self.upstr_data_cache[dl_loc]
> +
> +    def _get_upstr_data_wrapper(self, u, ud, destdir, md):
> +        """
> +        wrapper for self._get_upstr_data(), handling npmsw and gitsm fet=
chers
> +        """
> +        if md:
> +            revision =3D md["revision"]
> +            parent_url =3D md["parent_md"]["url"]
> +            parent_revision =3D md["parent_md"]["revision"]
> +        else:
> +            revision =3D parent_url =3D parent_revision =3D None
> +        if ud.type =3D=3D "npmsw" and ud.url =3D=3D u:
> +            local_path =3D ud.shrinkwrap_file
> +        elif ud.type =3D=3D "file":
> +            local_path =3D ud.localpath
> +        else:
> +            local_path =3D None
> +        upstr_data =3D self._get_upstr_data(u, ud, local_path, revision)
> +        # get parent data
> +        parent_is_shrinkwrap =3D (ud.type =3D=3D "npmsw" and parent_url =
=3D=3D ud.url)
> +        if ud.type in ["npmsw", "gitsm"] and parent_url and not parent_i=
s_shrinkwrap:
> +            parent_upstr_data =3D self._get_upstr_data(
> +                    parent_url, ud, None, parent_revision)
> +            dependency_of =3D upstr_data.setdefault("dependency_of", [])
> +            dependency_of.append(parent_upstr_data["download_location"])
> +        return upstr_data
> +
> +    def _collect_data(self, u, ud, files, links, destdir, md=3DNone):
> +        """collect data for the "committed" src uri entry (u)
> +
> +        data are saved using path_in_workdir as index; for each path_in_=
workdir,
> +        sha1 checksum and upstream data are collected (from cache, if av=
ailable,
> +        because self._get_upstr_data_wrapper() uses a cache)
> +
> +        sha1 and upstream data are appended to a list for each path_in_w=
orkdir,
> +        because it may happen that a file unpacked from a src uri gets
> +        overwritten by a subsequent src uri, from which a file with the =
same
> +        name/path is unpacked; the overwrite would be captured in the li=
st.
> +
> +        At the end, all data will be processed and grouped by download l=
ocation
> +        by self._process_data(), that will keep only the last item of
> +        sha1+upstream data list for each path_in_workdir
> +        """
> +        upstr_data =3D self._get_upstr_data_wrapper(u, ud, destdir, md)
> +        for f in files:
> +            sha1 =3D bb.utils.sha1_file(f)
> +            path_in_workdir =3D os.path.relpath(f, self.tmpdir)
> +            path_in_upstream =3D get_path_in_upstream(f, u, ud, destdir)
> +            data =3D self.td.setdefault(path_in_workdir, [])
> +            data.append({
> +                "sha1": sha1,
> +                "path_in_upstream": path_in_upstream,
> +                "upstream": upstr_data,
> +            })
> +        for l in links:
> +            link_target =3D os.readlink(l)
> +            path_in_workdir =3D os.path.relpath(l, self.tmpdir)
> +            path_in_upstream =3D get_path_in_upstream(l, u, ud, destdir)
> +            data =3D self.td.setdefault(path_in_workdir, [])
> +            data.append({
> +                "symlink_to": link_target,
> +                "path_in_upstream": path_in_upstream,
> +                "upstream": upstr_data,
> +            })
> +
> +    def _process_data(self):
> +        """group data by download location"""
> +        # it reduces json file size and allows faster processing by crea=
te-spdx
> +        pd =3D self.upstr_data_cache
> +        for workdir_path, data in self.td.items():
> +            data =3D data[-1] # pick last overwrite of the file, if any
> +            dl_loc =3D data["upstream"]["download_location"]
> +            files =3D pd[dl_loc].setdefault("files", {})
> +            path =3D data["path_in_upstream"]
> +            if path in files:
> +                files[path]["paths_in_workdir"].append(workdir_path)
> +                # the same source file may be found in different locatio=
ns in
> +                # workdir, eg. with npmsw fetcher, where the same npm mo=
dule
> +                # may unpacked multiple times in different paths
> +            else:
> +                path_data =3D files[path] =3D {}
> +                if data.get("sha1"):
> +                    path_data.update({ "sha1": data["sha1"] })
> +                elif data.get("symlink_to"):
> +                    path_data.update({ "symlink_to": data["symlink_to"] =
})
> +                path_data.update({ "paths_in_workdir": [workdir_path] } =
)
> +        self.td =3D pd
> +
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14722): https://lists.openembedded.org/g/bitbake-deve=
l/message/14722
> Mute This Topic: https://lists.openembedded.org/mt/98383892/1997914
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [raj.kh=
em@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

