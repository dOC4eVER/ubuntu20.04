Name:           xtreamui-freetype2
Version:        2.12.1
Release:        1%{?dist}
Summary:        xtreamui-freetype2

Group:          Development/Tools
License:        GPLv3
URL:            https://github.com/amidevous/xtream-ui-ubuntu20.04/
Source0:        https://download-mirror.savannah.gnu.org/releases/freetype/freetype-2.12.1.tar.xz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

BuildRequires: libX11-devel
BuildRequires: libpng-devel
BuildRequires: zlib-devel
BuildRequires: bzip2-devel
BuildRequires: gcc
Requires: libX11-devel
Requires: libpng-devel
Requires: zlib-devel
Requires: bzip2-devel

%description
xtreamui-freetype2

%prep
%setup -q -n freetype-2.12.0

%build
./configure --enable-freetype-config --prefix=/home/xtreamcodes/iptv_xtream_codes/freetype2
make %{?_smp_mflags}

%install
rm -rf $RPM_BUILD_ROOT
make install DESTDIR=$RPM_BUILD_ROOT

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
/home/xtreamcodes/iptv_xtream_codes/freetype2/bin/freetype-config
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/config/ftconfig.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/config/ftheader.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/config/ftmodule.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/config/ftoption.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/config/ftstdlib.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/config/integer-types.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/config/mac-support.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/config/public-macros.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/freetype.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftadvanc.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftbbox.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftbdf.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftbitmap.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftbzip2.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftcache.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftchapters.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftcid.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftcolor.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftdriver.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/fterrdef.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/fterrors.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftfntfmt.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftgasp.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftglyph.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftgxval.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftgzip.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftimage.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftincrem.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftlcdfil.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftlist.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftlogging.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftlzw.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftmac.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftmm.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftmodapi.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftmoderr.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftotval.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftoutln.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftparams.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftpfr.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftrender.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftsizes.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftsnames.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftstroke.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftsynth.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftsystem.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/fttrigon.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/fttypes.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ftwinfnt.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/otsvg.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/t1tables.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/ttnameid.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/tttables.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/freetype/tttags.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/include/freetype2/ft2build.h
/home/xtreamcodes/iptv_xtream_codes/freetype2/lib/libfreetype.a
%if 0%{?rhel}
/home/xtreamcodes/iptv_xtream_codes/freetype2/lib/libfreetype.la
%endif
%if 0%{?fedora} == 35
/home/xtreamcodes/iptv_xtream_codes/freetype2/lib/libfreetype.la
%endif
/home/xtreamcodes/iptv_xtream_codes/freetype2/lib/libfreetype.so
/home/xtreamcodes/iptv_xtream_codes/freetype2/lib/libfreetype.so.6
/home/xtreamcodes/iptv_xtream_codes/freetype2/lib/libfreetype.so.6.18.2
/home/xtreamcodes/iptv_xtream_codes/freetype2/lib/pkgconfig/freetype2.pc
/home/xtreamcodes/iptv_xtream_codes/freetype2/share/aclocal/freetype2.m4
/home/xtreamcodes/iptv_xtream_codes/freetype2/share/man/man1/freetype-config.1
%doc
%changelog
