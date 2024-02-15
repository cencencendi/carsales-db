PGDMP  
                    |            final_project    16.1    16.0 8    H           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            I           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            J           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            K           1262    17483    final_project    DATABASE     o   CREATE DATABASE final_project WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE final_project;
                postgres    false            �            1255    17562 Z   calculate_distance(double precision, double precision, double precision, double precision)    FUNCTION     B  CREATE FUNCTION public.calculate_distance(lat1 double precision, lon1 double precision, lat2 double precision, lon2 double precision) RETURNS double precision
    LANGUAGE plpgsql
    AS $$
DECLARE
    distance DOUBLE PRECISION;
BEGIN
    distance := SQRT((lat2 - lat1)^2 + (lon2 - lon1)^2);
    RETURN distance;
END;
$$;
 �   DROP FUNCTION public.calculate_distance(lat1 double precision, lon1 double precision, lat2 double precision, lon2 double precision);
       public          postgres    false            �            1259    17546    bids    TABLE     �   CREATE TABLE public.bids (
    bid_id integer NOT NULL,
    sales_id integer NOT NULL,
    buyer_id integer NOT NULL,
    date_bid date NOT NULL,
    bid_price integer NOT NULL
);
    DROP TABLE public.bids;
       public         heap    postgres    false            �            1259    17545    bids_bid_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bids_bid_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.bids_bid_id_seq;
       public          postgres    false    226            L           0    0    bids_bid_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.bids_bid_id_seq OWNED BY public.bids.bid_id;
          public          postgres    false    225            �            1259    17508    buyers    TABLE     �   CREATE TABLE public.buyers (
    buyer_id integer NOT NULL,
    name character varying(50) NOT NULL,
    phone character varying(15),
    city_id integer
);
    DROP TABLE public.buyers;
       public         heap    postgres    false            �            1259    17507    buyers_buyer_id_seq    SEQUENCE     �   CREATE SEQUENCE public.buyers_buyer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.buyers_buyer_id_seq;
       public          postgres    false    220            M           0    0    buyers_buyer_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.buyers_buyer_id_seq OWNED BY public.buyers.buyer_id;
          public          postgres    false    219            �            1259    17485    cities    TABLE     �   CREATE TABLE public.cities (
    city_id integer NOT NULL,
    name character varying(50) NOT NULL,
    latitude numeric(10,7) NOT NULL,
    longitude numeric(10,7) NOT NULL
);
    DROP TABLE public.cities;
       public         heap    postgres    false            �            1259    17484    cities_city_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cities_city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.cities_city_id_seq;
       public          postgres    false    216            N           0    0    cities_city_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.cities_city_id_seq OWNED BY public.cities.city_id;
          public          postgres    false    215            �            1259    17529    product_onsales    TABLE     �   CREATE TABLE public.product_onsales (
    sales_id integer NOT NULL,
    seller_id integer NOT NULL,
    product_id integer NOT NULL,
    price integer NOT NULL,
    is_negotiable boolean NOT NULL,
    date_post date NOT NULL
);
 #   DROP TABLE public.product_onsales;
       public         heap    postgres    false            �            1259    17528    product_onsales_sales_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_onsales_sales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.product_onsales_sales_id_seq;
       public          postgres    false    224            O           0    0    product_onsales_sales_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.product_onsales_sales_id_seq OWNED BY public.product_onsales.sales_id;
          public          postgres    false    223            �            1259    17522    products    TABLE       CREATE TABLE public.products (
    product_id integer NOT NULL,
    merk character varying(50) NOT NULL,
    model character varying(50) NOT NULL,
    body_type character varying(50) NOT NULL,
    transmission_type character varying(50) NOT NULL,
    year integer NOT NULL
);
    DROP TABLE public.products;
       public         heap    postgres    false            �            1259    17521    products_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.products_product_id_seq;
       public          postgres    false    222            P           0    0    products_product_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;
          public          postgres    false    221            �            1259    17494    sellers    TABLE     �   CREATE TABLE public.sellers (
    seller_id integer NOT NULL,
    name character varying(50) NOT NULL,
    phone character varying(15) NOT NULL,
    city_id integer
);
    DROP TABLE public.sellers;
       public         heap    postgres    false            �            1259    17493    sellers_seller_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sellers_seller_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.sellers_seller_id_seq;
       public          postgres    false    218            Q           0    0    sellers_seller_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.sellers_seller_id_seq OWNED BY public.sellers.seller_id;
          public          postgres    false    217            �           2604    17549    bids bid_id    DEFAULT     j   ALTER TABLE ONLY public.bids ALTER COLUMN bid_id SET DEFAULT nextval('public.bids_bid_id_seq'::regclass);
 :   ALTER TABLE public.bids ALTER COLUMN bid_id DROP DEFAULT;
       public          postgres    false    225    226    226            �           2604    17511    buyers buyer_id    DEFAULT     r   ALTER TABLE ONLY public.buyers ALTER COLUMN buyer_id SET DEFAULT nextval('public.buyers_buyer_id_seq'::regclass);
 >   ALTER TABLE public.buyers ALTER COLUMN buyer_id DROP DEFAULT;
       public          postgres    false    219    220    220            �           2604    17488    cities city_id    DEFAULT     p   ALTER TABLE ONLY public.cities ALTER COLUMN city_id SET DEFAULT nextval('public.cities_city_id_seq'::regclass);
 =   ALTER TABLE public.cities ALTER COLUMN city_id DROP DEFAULT;
       public          postgres    false    216    215    216            �           2604    17532    product_onsales sales_id    DEFAULT     �   ALTER TABLE ONLY public.product_onsales ALTER COLUMN sales_id SET DEFAULT nextval('public.product_onsales_sales_id_seq'::regclass);
 G   ALTER TABLE public.product_onsales ALTER COLUMN sales_id DROP DEFAULT;
       public          postgres    false    223    224    224            �           2604    17525    products product_id    DEFAULT     z   ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);
 B   ALTER TABLE public.products ALTER COLUMN product_id DROP DEFAULT;
       public          postgres    false    222    221    222            �           2604    17497    sellers seller_id    DEFAULT     v   ALTER TABLE ONLY public.sellers ALTER COLUMN seller_id SET DEFAULT nextval('public.sellers_seller_id_seq'::regclass);
 @   ALTER TABLE public.sellers ALTER COLUMN seller_id DROP DEFAULT;
       public          postgres    false    218    217    218            E          0    17546    bids 
   TABLE DATA           O   COPY public.bids (bid_id, sales_id, buyer_id, date_bid, bid_price) FROM stdin;
    public          postgres    false    226   *A       ?          0    17508    buyers 
   TABLE DATA           @   COPY public.buyers (buyer_id, name, phone, city_id) FROM stdin;
    public          postgres    false    220   �H       ;          0    17485    cities 
   TABLE DATA           D   COPY public.cities (city_id, name, latitude, longitude) FROM stdin;
    public          postgres    false    216   �N       C          0    17529    product_onsales 
   TABLE DATA           k   COPY public.product_onsales (sales_id, seller_id, product_id, price, is_negotiable, date_post) FROM stdin;
    public          postgres    false    224   mP       A          0    17522    products 
   TABLE DATA           _   COPY public.products (product_id, merk, model, body_type, transmission_type, year) FROM stdin;
    public          postgres    false    222   hR       =          0    17494    sellers 
   TABLE DATA           B   COPY public.sellers (seller_id, name, phone, city_id) FROM stdin;
    public          postgres    false    218   T       R           0    0    bids_bid_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.bids_bid_id_seq', 1, true);
          public          postgres    false    225            S           0    0    buyers_buyer_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.buyers_buyer_id_seq', 1, false);
          public          postgres    false    219            T           0    0    cities_city_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.cities_city_id_seq', 1, false);
          public          postgres    false    215            U           0    0    product_onsales_sales_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.product_onsales_sales_id_seq', 1, false);
          public          postgres    false    223            V           0    0    products_product_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.products_product_id_seq', 1, false);
          public          postgres    false    221            W           0    0    sellers_seller_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.sellers_seller_id_seq', 1, false);
          public          postgres    false    217            �           2606    17551    bids bids_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.bids
    ADD CONSTRAINT bids_pkey PRIMARY KEY (bid_id);
 8   ALTER TABLE ONLY public.bids DROP CONSTRAINT bids_pkey;
       public            postgres    false    226            �           2606    17515    buyers buyers_name_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.buyers
    ADD CONSTRAINT buyers_name_key UNIQUE (name);
 @   ALTER TABLE ONLY public.buyers DROP CONSTRAINT buyers_name_key;
       public            postgres    false    220            �           2606    17513    buyers buyers_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.buyers
    ADD CONSTRAINT buyers_pkey PRIMARY KEY (buyer_id);
 <   ALTER TABLE ONLY public.buyers DROP CONSTRAINT buyers_pkey;
       public            postgres    false    220            �           2606    17492    cities cities_name_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_name_key UNIQUE (name);
 @   ALTER TABLE ONLY public.cities DROP CONSTRAINT cities_name_key;
       public            postgres    false    216            �           2606    17490    cities cities_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (city_id);
 <   ALTER TABLE ONLY public.cities DROP CONSTRAINT cities_pkey;
       public            postgres    false    216            �           2606    17534 $   product_onsales product_onsales_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.product_onsales
    ADD CONSTRAINT product_onsales_pkey PRIMARY KEY (sales_id);
 N   ALTER TABLE ONLY public.product_onsales DROP CONSTRAINT product_onsales_pkey;
       public            postgres    false    224            �           2606    17527    products products_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);
 @   ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
       public            postgres    false    222            �           2606    17501    sellers sellers_name_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.sellers
    ADD CONSTRAINT sellers_name_key UNIQUE (name);
 B   ALTER TABLE ONLY public.sellers DROP CONSTRAINT sellers_name_key;
       public            postgres    false    218            �           2606    17499    sellers sellers_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.sellers
    ADD CONSTRAINT sellers_pkey PRIMARY KEY (seller_id);
 >   ALTER TABLE ONLY public.sellers DROP CONSTRAINT sellers_pkey;
       public            postgres    false    218            �           2606    17557    bids fk_buyer    FK CONSTRAINT     t   ALTER TABLE ONLY public.bids
    ADD CONSTRAINT fk_buyer FOREIGN KEY (buyer_id) REFERENCES public.buyers(buyer_id);
 7   ALTER TABLE ONLY public.bids DROP CONSTRAINT fk_buyer;
       public          postgres    false    220    3486    226            �           2606    17502    sellers fk_city    FK CONSTRAINT     t   ALTER TABLE ONLY public.sellers
    ADD CONSTRAINT fk_city FOREIGN KEY (city_id) REFERENCES public.cities(city_id);
 9   ALTER TABLE ONLY public.sellers DROP CONSTRAINT fk_city;
       public          postgres    false    216    218    3478            �           2606    17516    buyers fk_city    FK CONSTRAINT     s   ALTER TABLE ONLY public.buyers
    ADD CONSTRAINT fk_city FOREIGN KEY (city_id) REFERENCES public.cities(city_id);
 8   ALTER TABLE ONLY public.buyers DROP CONSTRAINT fk_city;
       public          postgres    false    216    3478    220            �           2606    17540    product_onsales fk_product    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_onsales
    ADD CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES public.products(product_id);
 D   ALTER TABLE ONLY public.product_onsales DROP CONSTRAINT fk_product;
       public          postgres    false    3488    222    224            �           2606    17552    bids fk_sale    FK CONSTRAINT     |   ALTER TABLE ONLY public.bids
    ADD CONSTRAINT fk_sale FOREIGN KEY (sales_id) REFERENCES public.product_onsales(sales_id);
 6   ALTER TABLE ONLY public.bids DROP CONSTRAINT fk_sale;
       public          postgres    false    3490    226    224            �           2606    17535    product_onsales fk_seller    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_onsales
    ADD CONSTRAINT fk_seller FOREIGN KEY (seller_id) REFERENCES public.sellers(seller_id);
 C   ALTER TABLE ONLY public.product_onsales DROP CONSTRAINT fk_seller;
       public          postgres    false    3482    218    224            E   �  x�m�[�f)��O��&Du/��u��fb:����$�3�'�����7���uJ��?˿��W�#v�oF飞'�Oڗ7�֞Ƙ���������d���G������������i1�������|�L�?���1���cL�P�L(�kN��'� �f�B�h�,�NXl��G�u@���d{(�q�sZ j�y偶ڢ۬k�䫝ۤ�/���~I��F�ڄ�>Ɨm.��p�v�lä���� �:Ӄ���}�炲G���!�%�ȱ�lQ�->���'l�ŎsA;�n��Lh)c1<r����p��)��.}��P[eO�1�T&E��T��Z"�2��6h���I��0��O��)<�c�mˢ]0��Lq�\.ZG5�%�G� -4a} Ng�����OS�Y5�JgM	�eAϘ�3������g:(ҴP�����?
�|�M�8 +c�N�k�yR��#
��E�#�D�r"����v�Ƣ*`��l�^s@�)��Ĩؙ-�P�փ��k�����Z�kj�0J;P��B2�)e�r^kF�����R�q%�u�������>i�o�5�omIu�!3"3�J�(��[I���+;���DJP�|����!�>��XAc^5�j�V��cdy)��-�10y����<T�ԭ��ԗe���>�U�Kb�yCo���g���RO�ϧ�Ht��y>Ջ/��Y|�
ɒ�┡�k^�f�#��J�(���S�qx�
]���zB��K�����m�KVĢ�,X�
���q�?��L�n�8�q������K+�:��E�U��4)�iAr���L���>�(���B�X6žu�[k�6H��:�Q\|XǞ|޲� i�뜷�K��E�E+�xN=(��t��&C��@��p_6�X�Z�p���FjHkW�W�g�h��n��MiF�{{)���v���qX_	ח҃�YZ;�X=_[�L�XN�R����ݥ\\������;y�!Ffb��/*��)Q,Lʸ,
���!�����V�{�.#�!�D��X��~s�m�pX���b���k$���0�;ٵ���2qy1d�.����2�f�kL]�,�������o��1���z�jA���k��Rk��M�B���<B&+Q����18�^En'Ʈm�ܯ6rtbt��ø_�ײ�'��y��`�o��w�ۅy�,����GٝѭG��������f�9��v%-"�|Sě�vI�4c�����h�T�0v����~v�!�"@0��q���.k$�]�ba����4���%���zaԧ� ��+骝��`u��
7�0C���t8/��pA�tex��BM�_#�ƽ���y�E�
��;��w��]��:��Ҭ�G���wx�������zٶE����)==�������jt`\C�`�o�Z���`�;�V(�ō�����������S*>��:��4 _]�y����s8p��U�$kp�}��z�����q������������?�\F�
�ԴR15'1��<��Q KH��[*]'R[h���#1��x��4�17�mN��4^���c�jZ��Ty1�c��pŉ��Ǚ��K[Y����0s<�P1��_�$bf�߄C���N��1����0��ǋ�r9rc���ι?K+}a�u�i�׾���khW�EՇ>�N�������Rv#����)&I3S��/�����������j���nh劉I�����`o��L��|�nɰ�n//�Յ���m�BI,������)�G������������k�qЍ9�Ӄ=I���]��F��Ͱ�������J���T7�$!�9郑I�/�Vw�Û������%]��(|D �k�-�W?���7�k��}�_�x���Zt�SX���F��#K���`�����Ks-WհI�������O�      ?     x�E��R�8��;O�Ж�/]5�T��-�����H<q�)Ł�<�����PE���wN[�U��>5/�n��(tEh�%m}X)����m�5�#Ũ�k[!��䵗+M��\�	7�1��Z�֋hu mp�З�15�R٥:�\	���m𤥷+�Ǥ����\O�Ë���R���^9zH��/8�v����/\��?���i����|���
����FD�ڹ�@7���k�>H�~�3Fq�z�;����\y�
��*oIj�([��W���ﻂ*�?�j=W)%��R�o�W�
�;$u��)��
��ǡ4�Ѓ�NH�Qm\.�tӧ��&7h�7K���:�.�D���ӱ�pK}O��b+�r���$������?2*�
�ET��iz����;5Oc��I�D4Q8kᥧ���.7��Wh)1|-�֟���y4O�l��790~%�vr�4�:a6�}�ۏ��	mek5k+W����u��BzH	�T���9����1 ��r�M;Lh�W)���q�%44t���I�֫�ci�c�=�K�z�
�(f:��Q�^��ڥ)�8F\��	e��A��\P����%A5�x�6����l�4@�SA��R��o5o���1U
�:�}��5�(�ei�_c`��G۪E�H?��8T@wJ���\0f> �~�xH�$�nrj\�%=�����WW�j�#۶5|D���%7/CV�EA�^j�N�l�G�;���
@�K� �i?M�<�?�3[������6u�1woo�'�Px�����ӎ��4�ޕ�Dw'����3+��!���e@����F.��B�l��O�.��%�π���H�h���F�4�� ���Z�y���r�*�p�;z�_k*����К��m#�,�C�_ ���,6�.��_���a����h�{ˎ�sc��ej~��n�0��.Z�i��>���4�N��D�-�K5cn]#��	F(C�E[^p����q���.g�T���e&��f��>_s�`yphZ��; q�u%1��S8���p�p�H#d���cΨ!f���>��ZI/���fy<e���v�X3�i��Y�����?t�@L i��&��'���H�3�Sp�����nQ�ҶZ�9!.�ӱ��E�1zz�;����\��>�d��ѳ.��=7_�o	X9P����4O�������"��R)�BǮ4^��3�h���5a����]:�	��x�NϚ ��k�`ˬ���fH�o�k�a�c�L���zr$~��s�m �! *��rH��]��tɼA[�P����#Ȇ1oԜ'2�E�O �r�.�94���^(D�
l��[5c���J��[&/�����f���z�#k�8M�y��Na��d�܁�A����ՇCX�n����[����׊�C�X��XN;O�]���7��g�&B�-Y��L��Č�2�m�a�>�Ru~���S?9I�]��i��4o�?���!C0J������w���f�X����,H~Ax�LE�x�y�c������Z��쥉      ;   i  x�U�M��@���)r�i꿻�&���'�@6<a����bn�j�2X�F�W�^�jƌ������g�|�o>�^,a1);K�*Bǘ��=��N(�+�� ɂ�3�zUg%��:2ê.�������Lp+;��s���cN&�^�h\7;�~��{ɩ,U�CJF��WV�0��Ͽ��T*��df�Z��-�?����Ccs�D�*$�����}��qn�-U�,"a3'�0��!o�o~\lB�ia�+�A�w�~?��i�өop�`���Ν=���ҟ�~m�b�r���ȉr)̍�o��>��ћ�a�6TNEme���5���<��X��Y�D�f@/���p��,�Ԩ��PA�5�M]��L��      C   �  x�mT[�$1����*��c�5��HEu��ځ����s7��W��]m\5��ϰ�@��P'�����!&��O��M�D�Z�s�:��&��⁂t�KL���
蒼�`\�u{w�k��IoB9��zM��;"�`Jb_���U�.S��-���B��zTj[х�zVF�Cm$�ͣ86�N�w�Ws�^���8�^f��|���mAr5%]�e�ͽ��9/&(��E:����{��4-�5X�RNzƉ��؎��Ȯ�������H<Fz�v����s�W�Qb~�j+�l�5��c���0kV�\3nC��i��}�g��j�7uK��z�������gp<���(���>ߓ��X:u�ۜ]����<W���؅<��C����7�_��@x�ڰ��[�����ۅ��S��i�UsC3ӟ]��a�b����z��]@�~�QW�����U�s���e����$F��W��|8�@��������s      A   �  x����j�0�뜧�l4M���2�tn�ݜ�hе��@�~�a�Ԧ7֋_�������c��呔�#�16��.�l�U�;&R�@��d,ՠb��,��#�H�x����т�ǖmScc�6C���8��~��<u��1�pGm|�u]9m�~����	�S�9p?�NK���v�͡����;'v�:v��������A�C�������jo�����r��͝��K�I� _U��y�NI3�HC���2D�ˡC4
0D����j����	O��"E��)*��nIol�,nY�_�.K�B�^��[(�0s
/"��OG�(޷cJ�*P�q���0]-�ߌS*NR	Y��j6mO��^�㾱��E��7���ϻ�u>���͊�      =   ;  x�5R�n�0=���?��ÝǬ�����JLLD!JN����J:�iފ�K-�C.�=_�ixP�+-X���p�L���9�@���[$��]�]l#{N�M� ��Q+��T@�1�M}�mjm�V� ���0�Z�e����2����3\	-�3����t��x��ȝ	:�9�y���~�2Li!���:p�`��P�+��c��+�4ZlR�
�4�BN�DŽ��1���1�q�'E��[����|Cv�-l_K�(-͝Bz_�X���eX�i����b�y6��`�"����~]ZId���[�^!��Ǳ�Hq�c)��p��
�-�2p�-Wv��>�!$*e�sʁ2�whW�;։�P�FQ&ڨ�����v?�V ̓"5k&r5��6Q��h��+�Y!H+1f[ؓc�����*�,r��U���ǹ�)�]K���b�Ⓐ&���D*��;����%'���!�2�U(%��V��B���i7��Y�s�[�sdO��-Z=����P?��줦�)�jO�y>��1Q@^��Ji�)��6M34�;m֐ȫ�??�����ղ     