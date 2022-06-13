

#pragma once

#define _USE_MATH_DEFINES

#include <math.h>
#include <iostream>

#define SMALL_float 0.0000000001



struct Vector2
{
    union
    {
        struct
        {
            float x;
            float y;
        };
        float data[2];
    };


    /**
     * Constructors.
     */
    inline Vector2();
    inline Vector2(float data[]);
    inline Vector2(float value);
    inline Vector2(float x, float y);


    /**
     * Constants for common vectors.
     */
    static inline Vector2 Zero();
    static inline Vector2 One();
    static inline Vector2 Right();
    static inline Vector2 Left();
    static inline Vector2 Up();
    static inline Vector2 Down();


    /**
     * Returns the angle between two vectors in radians.
     * @param a: The first vector.
     * @param b: The second vector.
     * @return: A scalar value.
     */
    static inline float Angle(Vector2 a, Vector2 b);

    /**
     * Returns a vector with its magnitude clamped to maxLength.
     * @param vector: The target vector.
     * @param maxLength: The maximum length of the return vector.
     * @return: A new vector.
     */
    static inline Vector2 ClampMagnitude(Vector2 vector, float maxLength);

    /**
     * Returns the component of a in the direction of b (scalar projection).
     * @param a: The target vector.
     * @param b: The vector being compared against.
     * @return: A scalar value.
     */
    static inline float Component(Vector2 a, Vector2 b);

    /**
     * Returns the distance between a and b.
     * @param a: The first point.
     * @param b: The second point.
     * @return: A scalar value.
     */
    static inline float Distance(Vector2 a, Vector2 b);

    /**
     * Returns the dot product of two vectors.
     * @param lhs: The left side of the multiplication.
     * @param rhs: The right side of the multiplication.
     * @return: A scalar value.
     */
    static inline float Dot(Vector2 lhs, Vector2 rhs);

    /**
     * Converts a polar representation of a vector into cartesian
     * coordinates.
     * @param rad: The magnitude of the vector.
     * @param theta: The angle from the x axis.
     * @return: A new vector.
     */
    static inline Vector2 FromPolar(float rad, float theta);

    /**
     * Returns a vector linearly interpolated between a and b, moving along
     * a straight line. The vector is clamped to never go beyond the end points.
     * @param a: The starting point.
     * @param b: The ending point.
     * @param t: The interpolation value [0-1].
     * @return: A new vector.
     */
    static inline Vector2 Lerp(Vector2 a, Vector2 b, float t);

    /**
     * Returns a vector linearly interpolated between a and b, moving along
     * a straight line.
     * @param a: The starting point.
     * @param b: The ending point.
     * @param t: The interpolation value [0-1] (no actual bounds).
     * @return: A new vector.
     */
    static inline Vector2 LerpUnclamped(Vector2 a, Vector2 b, float t);

    /**
     * Returns the magnitude of a vector.
     * @param v: The vector in question.
     * @return: A scalar value.
     */
    static inline float Magnitude(Vector2 v);

    /**
     * Returns a vector made from the largest components of two other vectors.
     * @param a: The first vector.
     * @param b: The second vector.
     * @return: A new vector.
     */
    static inline Vector2 Max(Vector2 a, Vector2 b);

    /**
     * Returns a vector made from the smallest components of two other vectors.
     * @param a: The first vector.
     * @param b: The second vector.
     * @return: A new vector.
     */
    static inline Vector2 Min(Vector2 a, Vector2 b);

    /**
     * Returns a vector "maxDistanceDelta" units closer to the target. This
     * interpolation is in a straight line, and will not overshoot.
     * @param current: The current position.
     * @param target: The destination position.
     * @param maxDistanceDelta: The maximum distance to move.
     * @return: A new vector.
     */
    static inline Vector2 MoveTowards(Vector2 current, Vector2 target,
                                      float maxDistanceDelta);

    /**
     * Returns a new vector with magnitude of one.
     * @param v: The vector in question.
     * @return: A new vector.
     */
    static inline Vector2 Normalized(Vector2 v);

    /**
     * Creates a new coordinate system out of the two vectors.
     * Normalizes "normal" and normalizes "tangent" and makes it orthogonal to
     * "normal"..
     * @param normal: A reference to the first axis vector.
     * @param tangent: A reference to the second axis vector.
     */
    static inline void OrthoNormalize(Vector2 &normal, Vector2 &tangent);

    /**
     * Returns the vector projection of a onto b.
     * @param a: The target vector.
     * @param b: The vector being projected onto.
     * @return: A new vector.
     */
    static inline Vector2 Project(Vector2 a, Vector2 b);

    /**
     * Returns a vector reflected about the provided line.
     * This behaves as if there is a plane with the line as its normal, and the
     * vector comes in and bounces off this plane.
     * @param vector: The vector traveling inward at the imaginary plane.
     * @param line: The line about which to reflect.
     * @return: A new vector pointing outward from the imaginary plane.
     */
    static inline Vector2 Reflect(Vector2 vector, Vector2 line);

    /**
     * Returns the vector rejection of a on b.
     * @param a: The target vector.
     * @param b: The vector being projected onto.
     * @return: A new vector.
     */
    static inline Vector2 Reject(Vector2 a, Vector2 b);

    /**
     * Rotates vector "current" towards vector "target" by "maxRadiansDelta".
     * This treats the vectors as directions and will linearly interpolate
     * between their magnitudes by "maxMagnitudeDelta". This function does not
     * overshoot. If a negative delta is supplied, it will rotate away from
     * "target" until it is pointing the opposite direction, but will not
     * overshoot that either.
     * @param current: The starting direction.
     * @param target: The destination direction.
     * @param maxRadiansDelta: The maximum number of radians to rotate.
     * @param maxMagnitudeDelta: The maximum delta for magnitude interpolation.
     * @return: A new vector.
     */
    static inline Vector2 RotateTowards(Vector2 current, Vector2 target,
                                        float maxRadiansDelta,
                                        float maxMagnitudeDelta);

    /**
     * Multiplies two vectors component-wise.
     * @param a: The lhs of the multiplication.
     * @param b: The rhs of the multiplication.
     * @return: A new vector.
     */
    static inline Vector2 Scale(Vector2 a, Vector2 b);

    /**
     * Returns a vector rotated towards b from a by the percent t.
     * Since interpolation is done spherically, the vector moves at a constant
     * angular velocity. This rotation is clamped to 0 <= t <= 1.
     * @param a: The starting direction.
     * @param b: The ending direction.
     * @param t: The interpolation value [0-1].
     */
    static inline Vector2 Slerp(Vector2 a, Vector2 b, float t);

    /**
     * Returns a vector rotated towards b from a by the percent t.
     * Since interpolation is done spherically, the vector moves at a constant
     * angular velocity. This rotation is unclamped.
     * @param a: The starting direction.
     * @param b: The ending direction.
     * @param t: The interpolation value [0-1].
     */
    static inline Vector2 SlerpUnclamped(Vector2 a, Vector2 b, float t);

    /**
     * Returns the squared magnitude of a vector.
     * This is useful when comparing relative lengths, where the exact length
     * is not important, and much time can be saved by not calculating the
     * square root.
     * @param v: The vector in question.
     * @return: A scalar value.
     */
    static inline float SqrMagnitude(Vector2 v);

    /**
     * Calculates the polar coordinate space representation of a vector.
     * @param vector: The vector to convert.
     * @param rad: The magnitude of the vector.
     * @param theta: The angle from the x axis.
     */
    static inline void ToPolar(Vector2 vector, float &rad, float &theta);


    /**
     * Operator overloading.
     */
    inline struct Vector2& operator+=(const float rhs);
    inline struct Vector2& operator-=(const float rhs);
    inline struct Vector2& operator*=(const float rhs);
    inline struct Vector2& operator/=(const float rhs);
    inline struct Vector2& operator+=(const Vector2 rhs);
    inline struct Vector2& operator-=(const Vector2 rhs);
};

inline Vector2 operator-(Vector2 rhs);
inline Vector2 operator+(Vector2 lhs, const float rhs);
inline Vector2 operator-(Vector2 lhs, const float rhs);
inline Vector2 operator*(Vector2 lhs, const float rhs);
inline Vector2 operator/(Vector2 lhs, const float rhs);
inline Vector2 operator+(const float lhs, Vector2 rhs);
inline Vector2 operator-(const float lhs, Vector2 rhs);
inline Vector2 operator*(const float lhs, Vector2 rhs);
inline Vector2 operator/(const float lhs, Vector2 rhs);
inline Vector2 operator+(Vector2 lhs, const Vector2 rhs);
inline Vector2 operator-(Vector2 lhs, const Vector2 rhs);
inline bool operator==(const Vector2 lhs, const Vector2 rhs);
inline bool operator!=(const Vector2 lhs, const Vector2 rhs);



/*******************************************************************************
 * Implementation
 */

Vector2::Vector2() : x(0), y(0) {}
Vector2::Vector2(float data[]) : x(data[0]), y(data[1]) {}
Vector2::Vector2(float value) : x(value), y(value) {}
Vector2::Vector2(float x, float y) : x(x), y(y) {}


Vector2 Vector2::Zero() { return Vector2(0, 0); }
Vector2 Vector2::One() { return Vector2(1, 1); }
Vector2 Vector2::Right() { return Vector2(1, 0); }
Vector2 Vector2::Left() { return Vector2(-1, 0); }
Vector2 Vector2::Up() { return Vector2(0, 1); }
Vector2 Vector2::Down() { return Vector2(0, -1); }


float Vector2::Angle(Vector2 a, Vector2 b)
{
    float v = Dot(a, b) / (Magnitude(a) * Magnitude(b));
    v = fmax(v, -1.0);
    v = fmin(v, 1.0);
    return acos(v);
}

Vector2 Vector2::ClampMagnitude(Vector2 vector, float maxLength)
{
    float length = Magnitude(vector);
    if (length > maxLength)
        vector *= maxLength / length;
    return vector;
}

float Vector2::Component(Vector2 a, Vector2 b)
{
    return Dot(a, b) / Magnitude(b);
}

float Vector2::Distance(Vector2 a, Vector2 b)
{
    return Vector2::Magnitude(a - b);
}

float Vector2::Dot(Vector2 lhs, Vector2 rhs)
{
    return lhs.x * rhs.x + lhs.y * rhs.y;
}

Vector2 Vector2::FromPolar(float rad, float theta)
{
    Vector2 v;
    v.x = rad * cos(theta);
    v.y = rad * sin(theta);
    return v;
}

Vector2 Vector2::Lerp(Vector2 a, Vector2 b, float t)
{
    if (t < 0) return a;
    else if (t > 1) return b;
    return LerpUnclamped(a, b, t);
}

Vector2 Vector2::LerpUnclamped(Vector2 a, Vector2 b, float t)
{
    return (b - a) * t + a;
}

float Vector2::Magnitude(Vector2 v)
{
    return sqrt(SqrMagnitude(v));
}

Vector2 Vector2::Max(Vector2 a, Vector2 b)
{
    float x = a.x > b.x ? a.x : b.x;
    float y = a.y > b.y ? a.y : b.y;
    return Vector2(x, y);
}

Vector2 Vector2::Min(Vector2 a, Vector2 b)
{
    float x = a.x > b.x ? b.x : a.x;
    float y = a.y > b.y ? b.y : a.y;
    return Vector2(x, y);
}

Vector2 Vector2::MoveTowards(Vector2 current, Vector2 target,
                             float maxDistanceDelta)
{
    Vector2 d = target - current;
    float m = Magnitude(d);
    if (m < maxDistanceDelta || m == 0)
        return target;
    return current + (d * maxDistanceDelta / m);
}

Vector2 Vector2::Normalized(Vector2 v)
{
    float mag = Magnitude(v);
    if (mag == 0)
        return Vector2::Zero();
    return v / mag;
}

void Vector2::OrthoNormalize(Vector2 &normal, Vector2 &tangent)
{
    normal = Normalized(normal);
    tangent = Reject(tangent, normal);
    tangent = Normalized(tangent);
}

Vector2 Vector2::Project(Vector2 a, Vector2 b)
{
    float m = Magnitude(b);
    return Dot(a, b) / (m * m) * b;
}

Vector2 Vector2::Reflect(Vector2 vector, Vector2 planeNormal)
{
    return vector - 2 * Project(vector, planeNormal);
}

Vector2 Vector2::Reject(Vector2 a, Vector2 b)
{
    return a - Project(a, b);
}

Vector2 Vector2::RotateTowards(Vector2 current, Vector2 target,
                               float maxRadiansDelta,
                               float maxMagnitudeDelta)
{
    float magCur = Magnitude(current);
    float magTar = Magnitude(target);
    float newMag = magCur + maxMagnitudeDelta *
                            ((magTar > magCur) - (magCur > magTar));
    newMag = fmin(newMag, fmax(magCur, magTar));
    newMag = fmax(newMag, fmin(magCur, magTar));

    float totalAngle = Angle(current, target) - maxRadiansDelta;
    if (totalAngle <= 0)
        return Normalized(target) * newMag;
    else if (totalAngle >= M_PI)
        return Normalized(-target) * newMag;

    float axis = current.x * target.y - current.y * target.x;
    axis = axis / fabs(axis);
    if (!(1 - fabs(axis) < 0.00001))
        axis = 1;
    current = Normalized(current);
    Vector2 newVector = current * cos(maxRadiansDelta) +
                        Vector2(-current.y, current.x) * sin(maxRadiansDelta) * axis;
    return newVector * newMag;
}

Vector2 Vector2::Scale(Vector2 a, Vector2 b)
{
    return Vector2(a.x * b.x, a.y * b.y);
}

Vector2 Vector2::Slerp(Vector2 a, Vector2 b, float t)
{
    if (t < 0) return a;
    else if (t > 1) return b;
    return SlerpUnclamped(a, b, t);
}

Vector2 Vector2::SlerpUnclamped(Vector2 a, Vector2 b, float t)
{
    float magA = Magnitude(a);
    float magB = Magnitude(b);
    a /= magA;
    b /= magB;
    float dot = Dot(a, b);
    dot = fmax(dot, -1.0);
    dot = fmin(dot, 1.0);
    float theta = acos(dot) * t;
    Vector2 relativeVec = Normalized(b - a * dot);
    Vector2 newVec = a * cos(theta) + relativeVec * sin(theta);
    return newVec * (magA + (magB - magA) * t);
}

float Vector2::SqrMagnitude(Vector2 v)
{
    return v.x * v.x + v.y * v.y;
}

void Vector2::ToPolar(Vector2 vector, float &rad, float &theta)
{
    rad = Magnitude(vector);
    theta = atan2(vector.y, vector.x);
}


struct Vector2& Vector2::operator+=(const float rhs)
{
    x += rhs;
    y += rhs;
    return *this;
}

struct Vector2& Vector2::operator-=(const float rhs)
{
    x -= rhs;
    y -= rhs;
    return *this;
}

struct Vector2& Vector2::operator*=(const float rhs)
{
    x *= rhs;
    y *= rhs;
    return *this;
}

struct Vector2& Vector2::operator/=(const float rhs)
{
    x /= rhs;
    y /= rhs;
    return *this;
}

struct Vector2& Vector2::operator+=(const Vector2 rhs)
{
    x += rhs.x;
    y += rhs.y;
    return *this;
}

struct Vector2& Vector2::operator-=(const Vector2 rhs)
{
    x -= rhs.x;
    y -= rhs.y;
    return *this;
}

Vector2 operator-(Vector2 rhs) { return rhs * -1; }
Vector2 operator+(Vector2 lhs, const float rhs) { return lhs += rhs; }
Vector2 operator-(Vector2 lhs, const float rhs) { return lhs -= rhs; }
Vector2 operator*(Vector2 lhs, const float rhs) { return lhs *= rhs; }
Vector2 operator/(Vector2 lhs, const float rhs) { return lhs /= rhs; }
Vector2 operator+(const float lhs, Vector2 rhs) { return rhs += lhs; }
Vector2 operator-(const float lhs, Vector2 rhs) { return rhs -= lhs; }
Vector2 operator*(const float lhs, Vector2 rhs) { return rhs *= lhs; }
Vector2 operator/(const float lhs, Vector2 rhs) { return rhs /= lhs; }
Vector2 operator+(Vector2 lhs, const Vector2 rhs) { return lhs += rhs; }
Vector2 operator-(Vector2 lhs, const Vector2 rhs) { return lhs -= rhs; }

bool operator==(const Vector2 lhs, const Vector2 rhs)
{
    return lhs.x == rhs.x && lhs.y == rhs.y;
}

bool operator!=(const Vector2 lhs, const Vector2 rhs)
{
    return !(lhs == rhs);
}

class Color {
public:
    float r, b, g, a;

    Color() {
        SetColor( 0 , 0 , 0 , 255 );
    }

    Color( float r , float g , float b ) {
        SetColor( r , g , b , 255 );
    }

    Color( float r, float g, float b, float a) {
        SetColor( r , g , b , a );
    }

    void SetColor( float r1 , float g1 , float b1 , float a1 = 255 ) {
        r = r1;
        g = g1;
        b = b1;
        a = a1;
    }

    static Color Black(float a = 255){ return Color(0, 0, 0, a); }
    static Color White(float a = 255){ return Color(255 , 255 , 255, a); }
    static Color Red(float a = 255){ return Color(255 , 0 , 0, a); }
    static Color Green(float a = 255){ return Color(0 , 255 , 0, a); }
    static Color Blue(float a = 255){ return Color(0 , 0 , 255, a); }
    static Color Yellow(float a = 255){ return Color(255 , 255 , 0, a); }
    static Color Cyan(float a = 255){ return Color(0 , 255 , 255, a); }
    static Color Magenta(float a = 255){ return Color(255 , 0 , 255, a); }
};

struct Vector3
{
    float x;
    float y;
    float z;

    Vector3();
    Vector3(float x, float y, float z);
    ~Vector3();


    /**
     * Constructors.
     */


    /**
     * Constants for common vectors.
     */
    static inline Vector3 zero();
    static inline Vector3 One();
    static inline Vector3 Right();
    static inline Vector3 Left();
    static inline Vector3 Up();
    static inline Vector3 Down();
    static inline Vector3 Forward();
    static inline Vector3 Backward();


    /**
     * Returns the angle between two vectors in radians.
     * @param a: The first vector.
     * @param b: The second vector.
     * @return: A scalar value.
     */
    static inline float Angle(Vector3 a, Vector3 b);

    /**
     * Returns a vector with its magnitude clamped to maxLength.
     * @param vector: The target vector.
     * @param maxLength: The maximum length of the return vector.
     * @return: A new vector.
     */
    static inline Vector3 ClampMagnitude(Vector3 vector, float maxLength);

    /**
     * Returns the component of a in the direction of b (scalar projection).
     * @param a: The target vector.
     * @param b: The vector being compared against.
     * @return: A scalar value.
     */
    static inline float Component(Vector3 a, Vector3 b);

    /**
     * Returns the cross product of two vectors.
     * @param lhs: The left side of the multiplication.
     * @param rhs: The right side of the multiplication.
     * @return: A new vector.
     */
    static inline Vector3 Cross(Vector3 lhs, Vector3 rhs);

    /**
     * Returns the distance between a and b.
     * @param a: The first point.
     * @param b: The second point.
     * @return: A scalar value.
     */
    static inline float Distance(Vector3 a, Vector3 b);

    static inline char ToChar(Vector3 a);

    /**
     * Returns the dot product of two vectors.
     * @param lhs: The left side of the multiplication.
     * @param rhs: The right side of the multiplication.
     * @return: A scalar value.
     */
    static inline float Dot(Vector3 lhs, Vector3 rhs);

    /**
     * Converts a spherical representation of a vector into cartesian
     * coordinates.
     * This uses the ISO convention (radius r, inclination theta, azimuth phi).
     * @param rad: The magnitude of the vector.
     * @param theta: The angle in the xy plane from the x axis.
     * @param phi: The angle from the positive z axis to the vector.
     * @return: A new vector.
     */
    static inline Vector3 FromSpherical(float rad, float theta, float phi);

    /**
     * Returns a vector linearly interpolated between a and b, moving along
     * a straight line. The vector is clamped to never go beyond the end points.
     * @param a: The starting point.
     * @param b: The ending point.
     * @param t: The interpolation value [0-1].
     * @return: A new vector.
     */
    static inline Vector3 Lerp(Vector3 a, Vector3 b, float t);

    /**
     * Returns a vector linearly interpolated between a and b, moving along
     * a straight line.
     * @param a: The starting point.
     * @param b: The ending point.
     * @param t: The interpolation value [0-1] (no actual bounds).
     * @return: A new vector.
     */
    static inline Vector3 LerpUnclamped(Vector3 a, Vector3 b, float t);

    /**
     * Returns the magnitude of a vector.
     * @param v: The vector in question.
     * @return: A scalar value.
     */
    static inline float Magnitude(Vector3 v);

    /**
     * Returns a vector made from the largest components of two other vectors.
     * @param a: The first vector.
     * @param b: The second vector.
     * @return: A new vector.
     */
    static inline Vector3 Max(Vector3 a, Vector3 b);

    /**
     * Returns a vector made from the smallest components of two other vectors.
     * @param a: The first vector.
     * @param b: The second vector.
     * @return: A new vector.
     */
    static inline Vector3 Min(Vector3 a, Vector3 b);

    /**
     * Returns a vector "maxDistanceDelta" units closer to the target. This
     * interpolation is in a straight line, and will not overshoot.
     * @param current: The current position.
     * @param target: The destination position.
     * @param maxDistanceDelta: The maximum distance to move.
     * @return: A new vector.
     */
    static inline Vector3 MoveTowards(Vector3 current, Vector3 target,
                                      float maxDistanceDelta);

    /**
     * Returns a new vector with magnitude of one.
     * @param v: The vector in question.
     * @return: A new vector.
     */
    static inline Vector3 Normalized(Vector3 v);

    /**
     * Returns an arbitrary vector orthogonal to the input.
     * This vector is not normalized.
     * @param v: The input vector.
     * @return: A new vector.
     */
    static inline Vector3 Orthogonal(Vector3 v);

    /**
     * Creates a new coordinate system out of the three vectors.
     * Normalizes "normal", normalizes "tangent" and makes it orthogonal to
     * "normal" and normalizes "binormal" and makes it orthogonal to both
     * "normal" and "tangent".
     * @param normal: A reference to the first axis vector.
     * @param tangent: A reference to the second axis vector.
     * @param binormal: A reference to the third axis vector.
     */
    static inline void OrthoNormalize(Vector3 &normal, Vector3 &tangent,
                                      Vector3 &binormal);

    /**
     * Returns the vector projection of a onto b.
     * @param a: The target vector.
     * @param b: The vector being projected onto.
     * @return: A new vector.
     */
    static inline Vector3 Project(Vector3 a, Vector3 b);

    /**
     * Returns a vector projected onto a plane orthogonal to "planeNormal".
     * This can be visualized as the shadow of the vector onto the plane, if
     * the light source were in the direction of the plane normal.
     * @param vector: The vector to project.
     * @param planeNormal: The normal of the plane onto which to project.
     * @param: A new vector.
     */
    static inline Vector3 ProjectOnPlane(Vector3 vector, Vector3 planeNormal);

    /**
     * Returns a vector reflected off the plane orthogonal to the normal.
     * The input vector is pointed inward, at the plane, and the return vector
     * is pointed outward from the plane, like a beam of light hitting and then
     * reflecting off a mirror.
     * @param vector: The vector traveling inward at the plane.
     * @param planeNormal: The normal of the plane off of which to reflect.
     * @return: A new vector pointing outward from the plane.
     */
    static inline Vector3 Reflect(Vector3 vector, Vector3 planeNormal);

    /**
     * Returns the vector rejection of a on b.
     * @param a: The target vector.
     * @param b: The vector being projected onto.
     * @return: A new vector.
     */
    static inline Vector3 Reject(Vector3 a, Vector3 b);

    /**
     * Rotates vector "current" towards vector "target" by "maxRadiansDelta".
     * This treats the vectors as directions and will linearly interpolate
     * between their magnitudes by "maxMagnitudeDelta". This function does not
     * overshoot. If a negative delta is supplied, it will rotate away from
     * "target" until it is pointing the opposite direction, but will not
     * overshoot that either.
     * @param current: The starting direction.
     * @param target: The destination direction.
     * @param maxRadiansDelta: The maximum number of radians to rotate.
     * @param maxMagnitudeDelta: The maximum delta for magnitude interpolation.
     * @return: A new vector.
     */
    static inline Vector3 RotateTowards(Vector3 current, Vector3 target,
                                        float maxRadiansDelta,
                                        float maxMagnitudeDelta);

    /**
     * Multiplies two vectors element-wise.
     * @param a: The lhs of the multiplication.
     * @param b: The rhs of the multiplication.
     * @return: A new vector.
     */
    static inline Vector3 Scale(Vector3 a, Vector3 b);

    /**
     * Returns a vector rotated towards b from a by the percent t.
     * Since interpolation is done spherically, the vector moves at a constant
     * angular velocity. This rotation is clamped to 0 <= t <= 1.
     * @param a: The starting direction.
     * @param b: The ending direction.
     * @param t: The interpolation value [0-1].
     */
    static inline Vector3 Slerp(Vector3 a, Vector3 b, float t);

    /**
     * Returns a vector rotated towards b from a by the percent t.
     * Since interpolation is done spherically, the vector moves at a constant
     * angular velocity. This rotation is unclamped.
     * @param a: The starting direction.
     * @param b: The ending direction.
     * @param t: The interpolation value [0-1].
     */
    static inline Vector3 SlerpUnclamped(Vector3 a, Vector3 b, float t);

    /**
     * Returns the squared magnitude of a vector.
     * This is useful when comparing relative lengths, where the exact length
     * is not important, and much time can be saved by not calculating the
     * square root.
     * @param v: The vector in question.
     * @return: A scalar value.
     */
    static inline float SqrMagnitude(Vector3 v);

    /**
     * Calculates the spherical coordinate space representation of a vector.
     * This uses the ISO convention (radius r, inclination theta, azimuth phi).
     * @param vector: The vector to convert.
     * @param rad: The magnitude of the vector.
     * @param theta: The angle in the xy plane from the x axis.
     * @param phi: The angle from the positive z axis to the vector.
     */
    static inline void ToSpherical(Vector3 vector, float &rad, float &theta,
                                   float &phi);


    /**
     * Operator overloading.
     */
    inline struct Vector3& operator+=(const float rhs);
    inline struct Vector3& operator-=(const float rhs);
    inline struct Vector3& operator*=(const float rhs);
    inline struct Vector3& operator/=(const float rhs);
    inline struct Vector3& operator+=(const Vector3 rhs);
    inline struct Vector3& operator-=(const Vector3 rhs);
};

inline Vector3 operator-(Vector3 rhs);
inline Vector3 operator+(Vector3 lhs, const float rhs);
inline Vector3 operator-(Vector3 lhs, const float rhs);
inline Vector3 operator*(Vector3 lhs, const float rhs);
inline Vector3 operator/(Vector3 lhs, const float rhs);
inline Vector3 operator+(const float lhs, Vector3 rhs);
inline Vector3 operator-(const float lhs, Vector3 rhs);
inline Vector3 operator*(const float lhs, Vector3 rhs);
inline Vector3 operator/(const float lhs, Vector3 rhs);
inline Vector3 operator+(Vector3 lhs, const Vector3 rhs);
inline Vector3 operator-(Vector3 lhs, const Vector3 rhs);
inline bool operator==(const Vector3 lhs, const Vector3 rhs);
inline bool operator!=(const Vector3 lhs, const Vector3 rhs);



/*******************************************************************************
 * Implementation
 */

Vector3::Vector3() {}
Vector3::Vector3(float x, float y, float z) : x(x), y(y), z(z) {}
Vector3::~Vector3() {}


Vector3 Vector3::zero() { return Vector3(0, 0, 0); }
Vector3 Vector3::One() { return Vector3(1, 1, 1); }
Vector3 Vector3::Right() { return Vector3(1, 0, 0); }
Vector3 Vector3::Left() { return Vector3(-1, 0, 0); }
Vector3 Vector3::Up() { return Vector3(0, 1, 0); }
Vector3 Vector3::Down() { return Vector3(0, -1, 0); }
Vector3 Vector3::Forward() { return Vector3(0, 0, 1); }
Vector3 Vector3::Backward() { return Vector3(0, 0, -1); }


float Vector3::Angle(Vector3 a, Vector3 b)
{
    float v = Dot(a, b) / (Magnitude(a) * Magnitude(b));
    v = fmax(v, -1.0);
    v = fmin(v, 1.0);
    return acos(v);
}

Vector3 Vector3::ClampMagnitude(Vector3 vector, float maxLength)
{
    float length = Magnitude(vector);
    if (length > maxLength)
        vector *= maxLength / length;
    return vector;
}

float Vector3::Component(Vector3 a, Vector3 b)
{
    return Dot(a, b) / Magnitude(b);
}

Vector3 Vector3::Cross(Vector3 lhs, Vector3 rhs)
{
    float x = lhs.y * rhs.z - lhs.z * rhs.y;
    float y = lhs.z * rhs.x - lhs.x * rhs.z;
    float z = lhs.x * rhs.y - lhs.y * rhs.x;
    return Vector3(x, y, z);
}

float Vector3::Distance(Vector3 a, Vector3 b)
{
    return Vector3::Magnitude(a - b);
}

float Vector3::Dot(Vector3 lhs, Vector3 rhs)
{
    return lhs.x * rhs.x + lhs.y * rhs.y + lhs.z * rhs.z;
}

Vector3 Vector3::FromSpherical(float rad, float theta, float phi)
{
    Vector3 v;
    v.x = rad * sin(theta) * cos(phi);
    v.y = rad * sin(theta) * sin(phi);
    v.z = rad * cos(theta);
    return v;
}

Vector3 Vector3::Lerp(Vector3 a, Vector3 b, float t)
{
    if (t < 0) return a;
    else if (t > 1) return b;
    return LerpUnclamped(a, b, t);
}

Vector3 Vector3::LerpUnclamped(Vector3 a, Vector3 b, float t)
{
    return (b - a) * t + a;
}

float Vector3::Magnitude(Vector3 v)
{
    return sqrt(SqrMagnitude(v));
}

Vector3 Vector3::Max(Vector3 a, Vector3 b)
{
    float x = a.x > b.x ? a.x : b.x;
    float y = a.y > b.y ? a.y : b.y;
    float z = a.z > b.z ? a.z : b.z;
    return Vector3(x, y, z);
}

Vector3 Vector3::Min(Vector3 a, Vector3 b)
{
    float x = a.x > b.x ? b.x : a.x;
    float y = a.y > b.y ? b.y : a.y;
    float z = a.z > b.z ? b.z : a.z;
    return Vector3(x, y, z);
}

Vector3 Vector3::MoveTowards(Vector3 current, Vector3 target,
                             float maxDistanceDelta)
{
    Vector3 d = target - current;
    float m = Magnitude(d);
    if (m < maxDistanceDelta || m == 0)
        return target;
    return current + (d * maxDistanceDelta / m);
}

Vector3 Vector3::Normalized(Vector3 v)
{
    float mag = Magnitude(v);
    if (mag == 0)
        return Vector3::zero();
    return v / mag;
}

Vector3 Vector3::Orthogonal(Vector3 v)
{
    return v.z < v.x ? Vector3(v.y, -v.x, 0) : Vector3(0, -v.z, v.y);
}

void Vector3::OrthoNormalize(Vector3 &normal, Vector3 &tangent,
                             Vector3 &binormal)
{
    normal = Normalized(normal);
    tangent = ProjectOnPlane(tangent, normal);
    tangent = Normalized(tangent);
    binormal = ProjectOnPlane(binormal, tangent);
    binormal = ProjectOnPlane(binormal, normal);
    binormal = Normalized(binormal);
}

Vector3 Vector3::Project(Vector3 a, Vector3 b)
{
    float m = Magnitude(b);
    return Dot(a, b) / (m * m) * b;
}

Vector3 Vector3::ProjectOnPlane(Vector3 vector, Vector3 planeNormal)
{
    return Reject(vector, planeNormal);
}

Vector3 Vector3::Reflect(Vector3 vector, Vector3 planeNormal)
{
    return vector - 2 * Project(vector, planeNormal);
}

Vector3 Vector3::Reject(Vector3 a, Vector3 b)
{
    return a - Project(a, b);
}

Vector3 Vector3::RotateTowards(Vector3 current, Vector3 target,
                               float maxRadiansDelta,
                               float maxMagnitudeDelta)
{
    float magCur = Magnitude(current);
    float magTar = Magnitude(target);
    float newMag = magCur + maxMagnitudeDelta *
                            ((magTar > magCur) - (magCur > magTar));
    newMag = fmin(newMag, fmax(magCur, magTar));
    newMag = fmax(newMag, fmin(magCur, magTar));

    float totalAngle = Angle(current, target) - maxRadiansDelta;
    if (totalAngle <= 0)
        return Normalized(target) * newMag;
    else if (totalAngle >= M_PI)
        return Normalized(-target) * newMag;

    Vector3 axis = Cross(current, target);
    float magAxis = Magnitude(axis);
    if (magAxis == 0)
        axis = Normalized(Cross(current, current + Vector3(3.95, 5.32, -4.24)));
    else
        axis /= magAxis;
    current = Normalized(current);
    Vector3 newVector = current * cos(maxRadiansDelta) +
                        Cross(axis, current) * sin(maxRadiansDelta);
    return newVector * newMag;
}

Vector3 Vector3::Scale(Vector3 a, Vector3 b)
{
    return Vector3(a.x * b.x, a.y * b.y, a.z * b.z);
}

Vector3 Vector3::Slerp(Vector3 a, Vector3 b, float t)
{
    if (t < 0) return a;
    else if (t > 1) return b;
    return SlerpUnclamped(a, b, t);
}

Vector3 Vector3::SlerpUnclamped(Vector3 a, Vector3 b, float t)
{
    float magA = Magnitude(a);
    float magB = Magnitude(b);
    a /= magA;
    b /= magB;
    float dot = Dot(a, b);
    dot = fmax(dot, -1.0);
    dot = fmin(dot, 1.0);
    float theta = acos(dot) * t;
    Vector3 relativeVec = Normalized(b - a * dot);
    Vector3 newVec = a * cos(theta) + relativeVec * sin(theta);
    return newVec * (magA + (magB - magA) * t);
}

float Vector3::SqrMagnitude(Vector3 v)
{
    return v.x * v.x + v.y * v.y + v.z * v.z;
}

void Vector3::ToSpherical(Vector3 vector, float &rad, float &theta,
                          float &phi)
{
    rad = Magnitude(vector);
    float v = vector.z / rad;
    v = fmax(v, -1.0);
    v = fmin(v, 1.0);
    theta = acos(v);
    phi = atan2(vector.y, vector.x);
}


struct Vector3& Vector3::operator+=(const float rhs)
{
    x += rhs;
    y += rhs;
    z += rhs;
    return *this;
}

struct Vector3& Vector3::operator-=(const float rhs)
{
    x -= rhs;
    y -= rhs;
    z -= rhs;
    return *this;
}

struct Vector3& Vector3::operator*=(const float rhs)
{
    x *= rhs;
    y *= rhs;
    z *= rhs;
    return *this;
}

struct Vector3& Vector3::operator/=(const float rhs)
{
    x /= rhs;
    y /= rhs;
    z /= rhs;
    return *this;
}

struct Vector3& Vector3::operator+=(const Vector3 rhs)
{
    x += rhs.x;
    y += rhs.y;
    z += rhs.z;
    return *this;
}

struct Vector3& Vector3::operator-=(const Vector3 rhs)
{
    x -= rhs.x;
    y -= rhs.y;
    z -= rhs.z;
    return *this;
}

Vector3 operator-(Vector3 rhs) { return rhs * -1; }
Vector3 operator+(Vector3 lhs, const float rhs) { return lhs += rhs; }
Vector3 operator-(Vector3 lhs, const float rhs) { return lhs -= rhs; }
Vector3 operator*(Vector3 lhs, const float rhs) { return lhs *= rhs; }
Vector3 operator/(Vector3 lhs, const float rhs) { return lhs /= rhs; }
Vector3 operator+(const float lhs, Vector3 rhs) { return rhs += lhs; }
Vector3 operator-(const float lhs, Vector3 rhs) { return rhs -= lhs; }
Vector3 operator*(const float lhs, Vector3 rhs) { return rhs *= lhs; }
Vector3 operator/(const float lhs, Vector3 rhs) { return rhs /= lhs; }
Vector3 operator+(Vector3 lhs, const Vector3 rhs) { return lhs += rhs; }
Vector3 operator-(Vector3 lhs, const Vector3 rhs) { return lhs -= rhs; }

bool operator==(const Vector3 lhs, const Vector3 rhs)
{
    return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z;
}

bool operator!=(const Vector3 lhs, const Vector3 rhs)
{
    return !(lhs == rhs);
}
/*
Vector3 get_position(void* transform) {
    if (!transform)
        return Vector3();

    Vector3 position;

    static const auto get_position_injected = reinterpret_cast<uint64_t(__fastcall*)(void*, Vector3&)>(getAbsoluteAddress("libil2cpp.so", 0x100B2D4));//UnityEngine.CoreModule
    get_position_injected(transform, position);

    return position;
}

void set_position(void* transform, Vector3 test) {
    if (transform) {
        static const auto set_position_injected = reinterpret_cast<uint64_t(__fastcall*)(void*, Vector3)>(getAbsoluteAddress("libil2cpp.so", 0x100B38C));//UnityEngine.CoreModule
        set_position_injected(transform, test);
    }
}

void set_localScale(void* transform, Vector3 test) {
    if (transform) {
        static const auto set_aposition_injected = reinterpret_cast<uint64_t(__fastcall*)(void*, Vector3)>(getAbsoluteAddress("libil2cpp.so", 0x100C270));//UnityEngine.CoreModule
        set_aposition_injected(transform, test);
    }
}

void* get_transform(void* player) {
    if (!player)
        return NULL;

    static const auto get_transform_injected = reinterpret_cast<uint64_t(__fastcall*)(void*)>(getAbsoluteAddress("libil2cpp.so", 0xC9AB30));//UnityEngine.CoreModule

    return (void*)get_transform_injected(player);
}


*/